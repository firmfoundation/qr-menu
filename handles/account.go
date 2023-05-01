package handles

import (
	"encoding/base64"
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"net/http"
	"os"
	"path/filepath"
	"strconv"

	"github.com/firmfoundation/qrmenu/initdb"
	"github.com/firmfoundation/qrmenu/models"
	"github.com/firmfoundation/qrmenu/pkg/auth"
	"github.com/firmfoundation/qrmenu/util"
	"github.com/go-chi/jwtauth"
	"github.com/go-playground/validator/v10"
	"github.com/google/uuid"
	"github.com/joho/godotenv"
	"gorm.io/gorm"
)

func HandleCreateAccount(w http.ResponseWriter, r *http.Request) error {
	if r.Method != http.MethodPost {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	account := &models.Account{}
	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(account)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: parsing in one or more submitted body fields.")
	}
	//validate
	//lets check payload
	v := validator.New()
	err = v.Struct(account)
	var err_detail string
	if err != nil {
		for _, e := range err.(validator.ValidationErrors) {
			err_detail += e.Error() + " "
			fmt.Println(e)
		}
		return util.CustomeError(nil, 400, err_detail)
	}

	if account.Email == "" || account.Password == "" {
		return util.CustomeError(nil, 400, "Error: Request missing one or more parameters")
	}

	s, err := account.CreateAccount(initdb.DB)
	if err != nil {
		var duplicateError *models.DuplicateError
		if errors.As(err, &duplicateError) {
			return util.CustomeError(nil, 409, "Error: account exists.")
		}
		return util.CustomeError(nil, 500, "Error: unable to create account data.")
	}

	//auth
	a := auth.Auth{}
	jwt, err := a.GetJwt(s.ID.String())
	if err != nil {
		return util.CustomeError(nil, 500, "Error: unable to authenticate.")
	}

	//send welcome email and new user registeration email to system admin
	go util.SendWelcomeEmail(s.Email, 97854)
	go util.SendToAdminNewAccount(s.Email)

	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/octet-stream")
	json.NewEncoder(w).Encode(auth.Jwt{JWT: jwt})

	return nil
}

func HandleAuthenticateAccount(w http.ResponseWriter, r *http.Request) error {
	if r.Method != http.MethodPost {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	account := &models.Account{}
	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(account)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: parsing in one or more submitted body fields.")
	}

	//validate
	//lets check payload
	v := validator.New()
	err = v.Struct(account)
	var err_detail string
	if err != nil {
		for _, e := range err.(validator.ValidationErrors) {
			err_detail += e.Error() + " "
			fmt.Println(e)
		}
		return util.CustomeError(nil, 400, err_detail)
	}

	if account.Email == "" || account.Password == "" {
		return util.CustomeError(nil, 400, "Error: Request missing one or more parameters")
	}

	jwt, err := account.AuthenticateAccount(initdb.DB)
	if err != nil {
		var notExitsError *models.NotExistsError
		var incorrectPasswordError *models.IncorrectPasswordError
		if errors.As(err, &notExitsError) {
			return util.CustomeError(nil, 404, "Error: account does not exists.")
		}

		if errors.As(err, &incorrectPasswordError) {
			return util.CustomeError(nil, 403, "Error: incorrect account password.")
		}
		return util.CustomeError(nil, 500, "Error: unable to create account data.")
	}

	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/octet-stream")
	json.NewEncoder(w).Encode(jwt)

	return nil
}

func HandleGenQR(w http.ResponseWriter, r *http.Request) error {
	_, claims, _ := jwtauth.FromContext(r.Context())
	id := claims["account_id"]

	account_id, ok := id.(string)
	if !ok {
		return util.CustomeError(nil, 500, "Error: server type error.")
	}

	account_uuid, err := uuid.Parse(account_id)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: server uuid parse error.")
	}

	if r.Method != http.MethodGet {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	account := &models.Account{}

	//add account_id
	account.ID = account_uuid
	a, err := account.GetAccountById(initdb.DB)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return util.CustomeError(nil, 404, "Error: account not found.")
		}
		return util.CustomeError(nil, 500, "Error: unable to Get account.")
	}

	//lets generate the QR png
	ex, err := os.Executable()

	if err != nil {
		log.Fatal(err)
	}
	exPath := filepath.Dir(ex)

	env, e := godotenv.Read(exPath + "/app.env")
	if e != nil {
		return util.CustomeError(nil, 500, "Error: loading env file.")
	}
	png, err := util.GenQR(a.QR, env["QR_MENU_PATH"]+"/"+a.QR)
	//base64
	b := "data:image/png;base64," + base64.StdEncoding.EncodeToString(png)

	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/octet-stream")
	w.Write([]byte(b))

	return nil
}

func HandleChangePasswordRequest(w http.ResponseWriter, r *http.Request) error {
	if r.Method != http.MethodPost {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	c := &models.ChangePassword{}
	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(c)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: parsing in one or more submitted fields.")
	}
	c, err = c.ChangePasswordRequest(initdb.DB)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return util.CustomeError(nil, 404, "Error: account not found.")
		}
		return util.CustomeError(nil, 500, "Error: unable to create change password request.")
	}

	//send mail
	go util.SendEmail(c.Email, c.JWT)

	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/json")
	//json.NewEncoder(w).Encode(s)

	return nil
}

func HandleAccountChangePassword(w http.ResponseWriter, r *http.Request) error {
	_, claims, _ := jwtauth.FromContext(r.Context())
	id := claims["account_id"]

	//get the jwt token used
	jwt_token := jwtauth.TokenFromHeader(r)
	if jwt_token == "" {
		return util.CustomeError(nil, 401, "Error: auth header token error.")
	}

	account_id, ok := id.(string)
	if !ok {
		return util.CustomeError(nil, 500, "Error: server type error.")
	}

	account_uuid, err := uuid.Parse(account_id)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: server uuid parse error.")
	}

	if r.Method != http.MethodPost {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	account := &models.Account{}
	decoder := json.NewDecoder(r.Body)
	err = decoder.Decode(account)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: parsing in one or more submitted body fields.")
	}

	//add account_id
	account.ID = account_uuid
	s, err := account.ChangeAccountPassword(initdb.DB, jwt_token)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: unable to create menu data.")
	}

	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/octet-stream")
	json.NewEncoder(w).Encode(s)

	return nil
}

func HandleUpdateTheme(w http.ResponseWriter, r *http.Request) error {
	_, claims, _ := jwtauth.FromContext(r.Context())
	id := claims["account_id"]

	account_id, ok := id.(string)
	if !ok {
		return util.CustomeError(nil, 500, "Error: server type error.")
	}

	account_uuid, err := uuid.Parse(account_id)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: server uuid parse error.")
	}

	if r.Method != http.MethodPost {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	theme_id := r.URL.Query().Get("theme_id")

	account := &models.Account{}
	account.ID = account_uuid
	account.Theme, _ = strconv.Atoi(theme_id)
	s, err := account.UpdateTheme(initdb.DB)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return util.CustomeError(nil, 404, "No available theme.")
		}
		return util.CustomeError(nil, 500, "Error: unable to update theme.")
	}

	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/octet-stream")
	json.NewEncoder(w).Encode(s)

	return nil
}

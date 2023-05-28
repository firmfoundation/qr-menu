package handles

import (
	"encoding/json"
	"errors"
	"html/template"
	"io"
	"log"
	"math"
	"net/http"
	"os"
	"path/filepath"
	"strconv"

	"github.com/firmfoundation/qrmenu/initdb"
	"github.com/firmfoundation/qrmenu/models"
	"github.com/firmfoundation/qrmenu/util"
	"github.com/go-chi/chi"
	"github.com/go-chi/jwtauth"
	"github.com/google/uuid"
	"github.com/shopspring/decimal"
	"gorm.io/gorm"
)

func HandleUpsertMenu(w http.ResponseWriter, r *http.Request) error {
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

	menu := &models.Menu{}
	decoder := json.NewDecoder(r.Body)
	err = decoder.Decode(menu)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: parsing in one or more submitted body fields.")
	}
	//round price
	menu.PriceS = decimal.NewFromFloat(math.Round(menu.PriceS.InexactFloat64()*100) / 100)
	menu.PriceL = decimal.NewFromFloat(math.Round(menu.PriceL.InexactFloat64()*100) / 100)

	//add account_id
	menu.AccountID = account_uuid
	s, err := menu.UpsertMenu(initdb.DB)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: unable to create menu data.")
	}

	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/octet-stream")
	json.NewEncoder(w).Encode(s)

	return nil
}

func HandleDeleteMenu(w http.ResponseWriter, r *http.Request) error {
	/*account id parse it from jwt*/
	_, claims, _ := jwtauth.FromContext(r.Context())
	id := claims["account_id"]

	account_id, ok := id.(string)
	if !ok {
		return util.CustomeError(nil, 500, "Error: server app error.")
	}

	account_uuid, err := uuid.Parse(account_id)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: server uuid parse error.")
	}

	if r.Method != http.MethodDelete {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	menu := &models.Menu{}
	decoder := json.NewDecoder(r.Body)
	err = decoder.Decode(menu)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: parsing in one or more submitted body fields.")
	}
	menu.AccountID = account_uuid

	s, err := menu.DeleteMenu(initdb.DB)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: unable to delete menu item.")
	}

	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/octet-stream")
	json.NewEncoder(w).Encode(s)

	return nil
}

func HandleGetMenuByAccountId(w http.ResponseWriter, r *http.Request) error {
	/*account id parse it from jwt*/
	_, claims, _ := jwtauth.FromContext(r.Context())
	id := claims["account_id"]

	account_id, ok := id.(string)
	if !ok {
		return util.CustomeError(nil, 500, "Error: server app error.")
	}

	if r.Method != http.MethodGet {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	//account_id := r.URL.Query().Get("account_id")
	menu := &models.Menu{}
	result := menu.GetMenuByAccountId(initdb.DB, account_id)

	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(result)
	return nil
}

func HandleGetMenuByQR(w http.ResponseWriter, r *http.Request) error {
	if r.Method != http.MethodGet {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	qr := r.URL.Query().Get("qr")
	offset, _ := strconv.Atoi(r.URL.Query().Get("o"))
	limit, _ := strconv.Atoi(r.URL.Query().Get("l"))

	menu := &models.Menu{}
	result := menu.GetMenuByQR(initdb.DB, qr, offset, limit)

	if len(result) > 0 {
		t := &models.Tracking{
			QR: qr,
		}
		go t.CreateTracking(initdb.DB)
	}

	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(result)
	return nil
}

func HandleGetMenuByQRAndCat(w http.ResponseWriter, r *http.Request) error {
	if r.Method != http.MethodGet {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	qr := r.URL.Query().Get("qr")
	cat := r.URL.Query().Get("cat")
	offset, _ := strconv.Atoi(r.URL.Query().Get("o"))
	limit, _ := strconv.Atoi(r.URL.Query().Get("l"))

	menu := &models.Menu{}
	result := menu.GetMenuByQRAndCat(initdb.DB, qr, cat, offset, limit)

	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(result)
	return nil
}

func ThemeTemplate(w http.ResponseWriter, r *http.Request) error {
	ex, err := os.Executable()

	if err != nil {
		log.Fatal(err)
	}
	exPath := filepath.Dir(ex)

	if r.Method != http.MethodGet {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	/* select theme */

	qr := chi.URLParam(r, "uid")

	account := &models.Account{}
	account.QR = qr

	a, err := account.GetAccountByQr(initdb.DB)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			t, _ := template.ParseFiles(exPath + "/templates/404.html")
			t.Execute(w, "")
			return nil
		}
		return util.CustomeError(nil, 404, "Error: server error.")
	}

	if a.Theme == 1 {
		t, _ := template.ParseFiles(exPath + "/templates/theme/menu.html")
		t.Execute(w, "")
		return nil
	} else if a.Theme == 2 {
		t, _ := template.ParseFiles(exPath + "/templates/theme/bright.html")
		t.Execute(w, "")
		return nil
	} else {
		t, _ := template.ParseFiles(exPath + "/templates/theme/bright.html")
		t.Execute(w, "")
		return nil
	}
}

func Menu2Template(w http.ResponseWriter, r *http.Request) error {
	ex, err := os.Executable()

	if err != nil {
		log.Fatal(err)
	}
	exPath := filepath.Dir(ex)

	if r.Method != http.MethodGet {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	/* select theme */

	qr := chi.URLParam(r, "uid")

	account := &models.Account{}
	account.QR = qr

	a, err := account.GetAccountByQr(initdb.DB)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			t, _ := template.ParseFiles(exPath + "/templates/404.html")
			t.Execute(w, "")
			return nil
		}
		return util.CustomeError(nil, 404, "Error: server error.")
	}

	if a.Theme == 1 {
		t, _ := template.ParseFiles(exPath + "/templates/menu.html")
		t.Execute(w, "")
		return nil
	} else if a.Theme == 2 {
		t, _ := template.ParseFiles(exPath + "/templates/bright.html")
		t.Execute(w, "")
		return nil
	} else {
		t, _ := template.ParseFiles(exPath + "/templates/bright.html")
		t.Execute(w, "")
		return nil
	}
}

func HandleMenuImage(w http.ResponseWriter, r *http.Request) error {
	if r.Method != http.MethodPost {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	/*account id parse it from jwt*/
	_, claims, _ := jwtauth.FromContext(r.Context())
	id := claims["account_id"]

	account_id, ok := id.(string)
	if !ok {
		return util.CustomeError(nil, 500, "Error: server app error.")
	}

	account_uuid, err := uuid.Parse(account_id)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: server uuid parse error.")
	}

	//
	menu_id := r.URL.Query().Get("menu_id")

	uid := uuid.New()
	img_file := uid.String() + ".png"

	err = r.ParseMultipartForm(32 << 20) // maxMemory 32MB
	if err != nil {
		return util.CustomeError(nil, 400, "Error: upload limit error")
	}

	file, _, err := r.FormFile("img")
	if err != nil {
		return util.CustomeError(nil, 400, "Error: server could not get the upload logo")
	}

	ex, err := os.Executable()
	if err != nil {
		log.Fatal(err)
	}
	exPath := filepath.Dir(ex)

	tmpfile, err := os.Create(exPath + "/static/img/menu/" + img_file)
	defer tmpfile.Close()
	if err != nil {
		return util.CustomeError(nil, 500, "Error: server could not create the image.")
	}
	_, err = io.Copy(tmpfile, file)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: server could not copy the image.")
	}

	//

	menu := &models.Menu{}

	//add account_id
	menu.AccountID = account_uuid
	menu.Image = img_file
	s, err := menu.UpdateMenuImage(initdb.DB, menu_id)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: unable to create image data.")
	}

	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/octet-stream")
	json.NewEncoder(w).Encode(s)

	return nil
}

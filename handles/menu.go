package handles

import (
	"encoding/json"
	"fmt"
	"html/template"
	"log"
	"math"
	"net/http"
	"os"
	"path/filepath"

	"github.com/firmfoundation/qrmenu/initdb"
	"github.com/firmfoundation/qrmenu/models"
	"github.com/firmfoundation/qrmenu/util"
	"github.com/go-chi/jwtauth"
	"github.com/google/uuid"
	"github.com/shopspring/decimal"
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
	menu := &models.Menu{}
	result := menu.GetMenuByQR(initdb.DB, qr)

	if len(result) > 0 {
		t := &models.Tracking{
			QR: qr,
		}
		fmt.Println("---------------------------------------- ", qr)
		go t.CreateTracking(initdb.DB)
	}

	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(result)
	return nil
}

func MenuTemplate(w http.ResponseWriter, r *http.Request) error {
	ex, err := os.Executable()

	if err != nil {
		log.Fatal(err)
	}
	exPath := filepath.Dir(ex)

	if r.Method != http.MethodGet {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	t, _ := template.ParseFiles(exPath + "/templates/menu.html")
	t.Execute(w, "")
	return nil
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

	t, _ := template.ParseFiles(exPath + "/templates/menu2.html")
	t.Execute(w, "")
	return nil
}

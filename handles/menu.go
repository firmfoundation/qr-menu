package handles

import (
	"encoding/json"
	"html/template"
	"log"
	"net/http"
	"os"
	"path/filepath"

	"github.com/firmfoundation/qrmenu/initdb"
	"github.com/firmfoundation/qrmenu/models"
	"github.com/firmfoundation/qrmenu/util"
)

func HandleCreateMenu(w http.ResponseWriter, r *http.Request) error {
	if r.Method != http.MethodPost {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	menu := &models.Menu{}
	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(menu)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: parsing in one or more submitted body fields.")
	}
	s, err := menu.CreateMenu(initdb.DB)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: unable to create menu data.")
	}

	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/octet-stream")
	json.NewEncoder(w).Encode(s)

	return nil
}

func HandleGetMenuByAccountId(w http.ResponseWriter, r *http.Request) error {
	if r.Method != http.MethodGet {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	account_id := r.URL.Query().Get("account_id")
	menu := &models.Menu{}
	result := menu.GetMenuByAccountId(initdb.DB, account_id)

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

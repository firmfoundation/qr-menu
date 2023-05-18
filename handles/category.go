package handles

import (
	"encoding/json"
	"net/http"

	"github.com/firmfoundation/qrmenu/initdb"
	"github.com/firmfoundation/qrmenu/models"
	"github.com/firmfoundation/qrmenu/util"
)

func HandleCreateCategory(w http.ResponseWriter, r *http.Request) error {
	if r.Method != http.MethodPost {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	category := &models.Category{}
	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(category)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: parsing in one or more submitted body fields.")
	}
	s, err := category.CreateCategory(initdb.DB)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: unable to create category data.")
	}

	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/octet-stream")
	json.NewEncoder(w).Encode(s)

	return nil
}

func HandleGetAllCategory(w http.ResponseWriter, r *http.Request) error {
	if r.Method != http.MethodGet {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	category := &models.Category{}
	result, err := category.GetAllCategory(initdb.DB)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: Unable to Get category data.")
	}

	w.WriteHeader(http.StatusAccepted)
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(result)
	return nil
}

func HandleGetCategoryByQR(w http.ResponseWriter, r *http.Request) error {
	if r.Method != http.MethodGet {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	qr := r.URL.Query().Get("qr")
	menu := &models.Category{}
	result := menu.GetCategoryByQR(initdb.DB, qr)

	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(result)
	return nil
}

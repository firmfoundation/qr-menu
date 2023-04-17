package handles

import (
	"encoding/json"
	"net/http"

	"github.com/firmfoundation/qrmenu/initdb"
	"github.com/firmfoundation/qrmenu/models"
	"github.com/firmfoundation/qrmenu/util"
)

func HandleCreateOrder(w http.ResponseWriter, r *http.Request) error {

	if r.Method != http.MethodPost {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	place_order := &models.PlaceOrder{}
	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(place_order)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: parsing in one or more submitted body fields.")
	}
	s, err := place_order.CreateOrder(initdb.DB)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: unable to create order.")
	}

	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/octet-stream")
	json.NewEncoder(w).Encode(s)

	return nil
}

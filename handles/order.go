package handles

import (
	"encoding/json"
	"errors"
	"net/http"

	"github.com/firmfoundation/qrmenu/initdb"
	"github.com/firmfoundation/qrmenu/models"
	"github.com/firmfoundation/qrmenu/util"
	"github.com/go-chi/jwtauth"
	"gorm.io/gorm"
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

	//send order notification
	go util.EmailOrder()

	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/octet-stream")
	json.NewEncoder(w).Encode(s)

	return nil
}

func HandleGetOrders(w http.ResponseWriter, r *http.Request) error {
	_, claims, _ := jwtauth.FromContext(r.Context())
	id := claims["account_id"]

	account_id, ok := id.(string)
	if !ok {
		return util.CustomeError(nil, 500, "Error: server type error.")
	}

	status := r.URL.Query().Get("status")

	if r.Method != http.MethodGet {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	order := &models.Order{}
	s, err := order.GetOrderByStatus(initdb.DB, account_id, status)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return util.CustomeError(nil, 404, "No available order.")
		}
		return util.CustomeError(nil, 500, "Error: unable to fetch orders.")
	}

	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/octet-stream")
	json.NewEncoder(w).Encode(s)

	return nil
}

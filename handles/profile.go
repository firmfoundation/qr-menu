package handles

import (
	"encoding/json"
	"errors"
	"fmt"
	"net/http"

	"github.com/firmfoundation/qrmenu/initdb"
	"github.com/firmfoundation/qrmenu/models"
	"github.com/firmfoundation/qrmenu/util"
	"github.com/go-chi/jwtauth"
	"github.com/google/uuid"
	"gorm.io/gorm"
)

func HandleCreateProfile(w http.ResponseWriter, r *http.Request) error {
	if r.Method != http.MethodPost {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	profile := &models.Profile{}
	decoder := json.NewDecoder(r.Body)
	err := decoder.Decode(profile)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: parsing in one or more submitted body fields.")
	}
	s, err := profile.CreateProfile(initdb.DB)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: unable to create profile data.")
	}

	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/octet-stream")
	json.NewEncoder(w).Encode(s)

	return nil
}

func HandleUpsertProfile(w http.ResponseWriter, r *http.Request) error {
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

	if r.Method != http.MethodPost {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	profile := &models.Profile{}
	decoder := json.NewDecoder(r.Body)
	err = decoder.Decode(profile)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: parsing in one or more submitted body fields.")
	}

	//add account_id
	profile.AccountID = account_uuid

	s, err := profile.UpdateProfile(initdb.DB)
	if err != nil {
		return util.CustomeError(nil, 500, "Error: unable to create profile data.")
	}

	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/octet-stream")
	json.NewEncoder(w).Encode(s)

	return nil
}

func HandleGetProfileByAccount(w http.ResponseWriter, r *http.Request) error {
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

	profile := &models.Profile{}
	result, err := profile.GetProfileByAccount(initdb.DB, account_id)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return util.CustomeError(nil, 404, "Error: profile not found.")
		}
		return util.CustomeError(nil, 500, "Error: unable to Get profile data.")
	}

	w.WriteHeader(http.StatusAccepted)
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(result)
	return nil
}

func HandleGetProfileByQR(w http.ResponseWriter, r *http.Request) error {
	if r.Method != http.MethodGet {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	qr := r.URL.Query().Get("qr")
	profile := &models.Profile{}
	result, err := profile.GetProfileByQR(initdb.DB, qr)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return util.CustomeError(nil, 404, "Error: profile not found.")
		}
		return util.CustomeError(nil, 500, "Error: unable to Get profile data.")
	}
	fmt.Println(result.BusinessName)
	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(result)
	return nil
}

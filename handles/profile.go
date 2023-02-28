package handles

import (
	"encoding/json"
	"net/http"

	"github.com/firmfoundation/qrmenu/initdb"
	"github.com/firmfoundation/qrmenu/models"
	"github.com/firmfoundation/qrmenu/util"
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

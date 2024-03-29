package handles

import (
	"fmt"
	"html/template"
	"log"
	"net/http"
	"os"
	"path/filepath"

	"github.com/firmfoundation/qrmenu/util"
	"github.com/go-chi/jwtauth"
)

func HandleAdminTemplate(w http.ResponseWriter, r *http.Request) error {
	_, claims, _ := jwtauth.FromContext(r.Context())
	fmt.Println("--------------->", claims["account_id"])

	ex, err := os.Executable()

	if err != nil {
		log.Fatal(err)
	}
	exPath := filepath.Dir(ex)

	if r.Method != http.MethodGet {
		return util.CustomeError(nil, 405, "Error: Method not allowed.")
	}

	t, _ := template.ParseFiles(exPath + "/templates/admin.html")
	t.Execute(w, "")
	return nil
}

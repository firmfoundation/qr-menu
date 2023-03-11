package handles

import (
	"html/template"
	"log"
	"net/http"
	"os"
	"path/filepath"

	"github.com/firmfoundation/qrmenu/util"
)

func HandleAdminTemplate(w http.ResponseWriter, r *http.Request) error {
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

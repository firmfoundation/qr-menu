package main

import (
	"log"
	"net/http"
	"os"
	"path/filepath"

	"github.com/firmfoundation/qrmenu/initdb"
)

var port string = ":5055"

func init() {
	ex, err := os.Executable()

	if err != nil {
		log.Fatal(err)
	}
	exPath := filepath.Dir(ex)

	conf, err := initdb.LoadConfig(exPath + "/app.env")

	if err != nil {
		log.Fatalf("Error loading .env file")
	}

	initdb.ConnectDB(&conf)
	initdb.Migrate()
}
func main() {
	log.Printf("Starting api service on port %v\n", port)
	if err := http.ListenAndServe(port, router()); err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}

package main

import (
	"log"
	"net/http"

	"github.com/firmfoundation/qrmenu/util"
)

type Handler func(w http.ResponseWriter, r *http.Request) error

func (h Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	if err := h(w, r); err != nil {
		// handle returned error here and Log the error.
		log.Printf("An error accured: %v", err)

		//lets check error type
		customError, ok := err.(util.ClientError)

		if !ok {
			//error is not http error type ,
			w.WriteHeader(500) // retrun 500 internal server error
			return
		}

		body, err := customError.ResponseBody()
		if err != nil {
			log.Printf("An error accured: %v", err)
			w.WriteHeader(500)
			return
		}
		status, headers := customError.ResponseHeaders() // Get http status code and headers.
		for k, v := range headers {
			w.Header().Set(k, v)
		}
		w.WriteHeader(status)
		w.Write(body)
	}
}

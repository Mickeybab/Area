package routes

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"github.com/frouioui/AREA/api/email-back-up/client/models"

	"github.com/frouioui/AREA/api/email-back-up/client"

	"github.com/gorilla/mux"
)

// Assign all the routes to a mux Router
func Assign(r *mux.Router) {
	log.Println("Setting up routes ...")
	r.HandleFunc("/v2/email/", homeRoute).Methods(http.MethodGet, http.MethodOptions)
	r.HandleFunc("/v2/email", homeRoute).Methods(http.MethodGet, http.MethodOptions)
	r.HandleFunc("/v2/email/send", getOneRateRoute).Methods(http.MethodPost, http.MethodOptions)
	log.Println("Routes set.")
}

func homeRoute(w http.ResponseWriter, r *http.Request) {

	w.Write([]byte(`{"status": "success", "code": 200}`))
}

func getOneRateRoute(w http.ResponseWriter, r *http.Request) {

	email := models.Email{}
	err := json.NewDecoder(r.Body).Decode(&email)
	if err != nil {
		w.WriteHeader(400)
		log.Println(err)
		fmt.Fprintf(w, `{"status": "failure", "code": %d, "message": "%s"}`, 400, err)
		return
	}

	err = client.Send(email)
	if err != nil {
		w.WriteHeader(400)
		log.Println(err)
		fmt.Fprintf(w, `{"status": "failure", "code": %d, "message": "%s"}`, 400, err)
		return
	}
	w.WriteHeader(200)
	fmt.Fprintf(w, `{"status": "success", "code": %d, "data": %s}`, 200, "ok")
	return
}

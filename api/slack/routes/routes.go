package routes

import (
	"fmt"
	"log"
	"net/http"

	"github.com/frouioui/AREA/api/slack/client"
	"github.com/gorilla/mux"
)

// Assign all the routes to a mux Router
func Assign(r *mux.Router) {
	log.Println("Setting up routes ...")
	r.HandleFunc("/v1/slack/", homeRoute).Methods(http.MethodGet, http.MethodOptions)
	r.HandleFunc("/v1/slack", homeRoute).Methods(http.MethodGet, http.MethodOptions)
	r.HandleFunc("/v1/slack/send", sendMessageHandler).Methods(http.MethodPost, http.MethodOptions)
	log.Println("Routes set.")
}

func homeRoute(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte(`{"status": "success", "code": 200}`))
}

func sendMessageHandler(w http.ResponseWriter, r *http.Request) {
	msg, okmsg := r.URL.Query()["msg"]

	if !okmsg || len(msg[0]) < 1 {
		w.WriteHeader(400)
		fmt.Fprintf(w, `{"status": "failure", "code": %d, "message": "%s"}`, 400, "invalid query params")
		return
	}

	client.SendMessage(msg[0])

	w.WriteHeader(200)
	fmt.Fprintf(w, `{"status": "success", "code": %d, "data": %s}`, 200, "ok")
	return
}

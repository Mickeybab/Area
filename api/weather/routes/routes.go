package routes

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"github.com/frouioui/AREA/api/weather/client"

	"github.com/gorilla/mux"
)

// Assign all the routes to a mux Router
func Assign(r *mux.Router) {
	log.Println("Setting up routes ...")
	r.HandleFunc("/v1/weather/", homeRoute).Methods(http.MethodGet, http.MethodOptions)
	r.HandleFunc("/v1/weather", homeRoute).Methods(http.MethodGet, http.MethodOptions)
	r.HandleFunc("/v1/weather/city", getCityWeather).Methods(http.MethodGet, http.MethodOptions)
	log.Println("Routes set.")
}

func homeRoute(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte(`{"status": "success", "code": 200}`))
}

func getCityWeather(w http.ResponseWriter, r *http.Request) {
	city, okCity := r.URL.Query()["city"]

	if !okCity || len(city[0]) < 1 {
		w.WriteHeader(400)
		fmt.Fprintf(w, `{"status": "failure", "code": %d, "message": "%s"}`, 400, "invalid query params")
		return
	}
	info, err := client.GetTemperatureCity(city[0])
	if err != nil {
		w.WriteHeader(400)
		log.Println(err)
		fmt.Fprintf(w, `{"status": "failure", "code": %d, "message": "%s"}`, 400, err)
		return
	}
	info.Info.Temp -= 273.15
	infoJSON, err := json.Marshal(info.Info)
	if err != nil {
		w.WriteHeader(500)
		log.Println(err)
		fmt.Fprintf(w, `{"status": "failure", "code": %d, "message": "%s"}`, 500, err)
	}

	w.WriteHeader(200)
	fmt.Fprintf(w, `{"status": "success", "code": %d, "data": %s}`, 200, infoJSON)
	return
}

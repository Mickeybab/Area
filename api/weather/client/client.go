package client

import (
	"encoding/json"
	"io/ioutil"
	"net/http"

	"github.com/frouioui/AREA/api/weather/client/models"
)

const (
	urlAPI   = "http://api.openweathermap.org/data/2.5/weather?q="
	tokenAPI = "&APPID=517b6fc349eb9f9db7ad4cae4162f0be"
)

func GetTemperatureCity(city string) (info models.WeatherInfo, err error) {
	url := urlAPI + city + tokenAPI

	resp, err := http.Get(url)
	if err != nil {
		return info, err
	}

	defer resp.Body.Close()

	respBody, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return info, err
	}
	err = json.Unmarshal(respBody, &info)
	if err != nil {
		return info, err
	}
	return info, err
}

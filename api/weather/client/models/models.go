package models

type TemperatureInfo struct {
	Temp float64 `json:"temp"`
}

type WeatherInfo struct {
	Info TemperatureInfo `json:"main"`
}

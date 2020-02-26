package models

type Email struct {
	Content string `json:"content"`
	To      string `json:"to"`
	Subject string `json:"subject"`
}

package models

type Event struct {
	User string `json:"user"`
	Text string `json:"text"`
}

type Payload struct {
	Event Event `json:"event"`
}

type Challenge struct {
	Token     string `json:"token"`
	Challenge string `json:"challenge"`
	Type      string `json:"type"`
}

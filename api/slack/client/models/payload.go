package models

// type Item struct {
// 	Type    string
// 	Channel string
// }

type Event struct {
	Type string
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

package client

import (
	"bytes"
	"fmt"
	"net/http"
)

const (
	urlAPI = "https://hooks.slack.com/services/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"
)

func SendMessage(message string) (err error) {
	url := urlAPI

	jsonValue := fmt.Sprintf(`{"text": "%s"}`, message)
	resp, err := http.Post(url, "application/json", bytes.NewBuffer([]byte(jsonValue)))
	if err != nil {
		return err
	}

	defer resp.Body.Close()

	return err
}

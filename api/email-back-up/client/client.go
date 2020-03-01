package client

import (
	"fmt"
	"log"

	"github.com/frouioui/AREA/api/email-back-up/client/models"
	"github.com/sendgrid/sendgrid-go"
	"github.com/sendgrid/sendgrid-go/helpers/mail"
)

var (
	urlAPI = "https://api.exchangeratesapi.io"
)

func Send(email models.Email) (err error) {
	from := mail.NewEmail("AREA", "florent.poinsard@epitech.eu")
	subject := email.Subject
	to := mail.NewEmail("AREA", email.To)
	plainTextContent := email.Content
	htmlContent := email.Content
	message := mail.NewSingleEmail(from, subject, to, plainTextContent, htmlContent)
	client := sendgrid.NewSendClient("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")
	response, err := client.Send(message)
	if err != nil {
		log.Println(err)
		return err
	}
	fmt.Println(response.StatusCode)
	fmt.Println(response.Body)
	fmt.Println(response.Headers)
	return nil
}

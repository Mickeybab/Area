# First stage -> Building / Compiling server
FROM golang:1.12.5 AS builder

WORKDIR  /go/src/github.com/frouioui/AREA/api/email-back-up

RUN go get -u github.com/sendgrid/sendgrid-go
RUN go get -u github.com/gorilla/mux
RUN go get -u github.com/gorilla/handlers
RUN go get -u github.com/sendgrid/sendgrid-go/helpers/mail

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# Second stage -> Running server
FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=builder /go/src/github.com/frouioui/AREA/api/email-back-up/main .

EXPOSE 8080

CMD [ "./main" ]
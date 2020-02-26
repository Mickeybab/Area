# **Epitech Email (Backup) API**

## **Version**

v2.0.0

## **Author**

- florent.poinsard@epitech.eu

## **Tech choice**

This API is a Golang (v1.12) based application.

Why Golang? Golang is a fast and realiable language allowing us to deliver a fast and safe API.

Goland is a programming language used more and more by companies, its reliability and speed makes him a great language.

No frameworks were used.

## **Description**

The Currency API enable developers to uses the wrapper of the [currency API](https://exchangeratesapi.io) we provide on pedafy.com.

This API uses the Richardson Maturity Model, more info [here](https://martinfowler.com/articles/richardsonMaturityModel.html).

## **Routes**

| Action | Method | Route |
| ---- | ---- | ---- |
| Send email | `POST` | `/v2/email/send` |

### ***Development URL***

- http://localhost:9007/v2/email ...

## **Routes description**

### **Send email**

Request type: `POST`.

URL: `/v2/email/send`.

The request's body should contains those fields:
```json
{
    "to": "email@toto.com",
    "content": "the message here",
    "subject": "the email's subject"
}
```

Here is an example of a **response**:
```json
{
    "status": "success",
    "code": 200,
    "data": "ok"
}
```

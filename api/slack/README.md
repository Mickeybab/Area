# **Epitech Slack API**

## **Version**

v1.0.0

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
| Send a Slack message | `POST` | `/v1/slack/send?msg=xxx` |
| Get Slack's messages | `GET` | `/v1/slack/message` |


### ***Development URL***

- http://localhost:9008/v1/slack ...

## **Routes description**

### **Send a message**

Request type: `POST`.

URL: `/v1/slack/send?msg=xxx`.

Send a slack message containing the `msg` value.

Here is an example of a **response**:
```json
{
    "status": "success",
    "code": 200,
    "data": "ok"
}
```

### **Get messages**

Request type: `GET`.

URL: `/v1/slack/message`

Get all the awaiting slack messages.

Here is an example of a **response**:
```json
{
    "status": "success",
    "code": 200,
    "data": [{
            "user": "toto",
            "text": "salut"
        },
        {
            "user": "enzo",
            "text": "autodicar"
        }
    ]
}
```

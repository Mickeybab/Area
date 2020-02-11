# AREA

## Services

- Outlook Mail
- Github
- OpenWeather
- ExchangeRateApi
- Slack
- Epitech intranet

## Actions / Reactions

### Actions

- Receive an email
- Receive an intranet notification
- Report a mark below a limit
- Report a credit number that exceeds a target
- The GPA drops below a threshold
- The GPA exceeds a threshold
- A commit was made on a specific repo
- The temperature exceeds a threshold
- The temperature is below a threshold
- The value of a currency drops below a threshold
- The value of a currency exceeds a threshold
- Receive a slack notification

### Reactions

- Notifications
- Emails
- Messages

## Requests

### Get all the activated applets

Method: **`GET`**

URL: `API_URL/applets`

```json
[
  {
    "id": "ID",
    "title": "Follow My Progression",
    "description": "Get a message when the GPA ...",
    "color" : "0xffb74093",
    "enable": false,
    "action": {
      "service": "intranet",
      "logo": "path",
      "action": "get the GPA",
      "param": [
        {
          "name": "parameter name",
          "type": "string/int",
          "value": "",
        },
        ...
      ],
    },
    "reaction": {
      "service": "slack",
      "logo": "path",
      "reaction": "message",
      "param": [
        {
          "name": "parameter name",
          "type": "string/int",
          "value": "",
        },
        ...
      ]
    }
  },
  ...
]
```

### Get an applet

Method: **`GET`**

URL: `API_URL/applets/${id}`

```json
{
  "id": "ID",
  "title": "Follow My Progression",
  "description": "Get a message when the GPA ...",
  "color" : "0xffb74093",
  "enable": false,
  "action": {
    "service": "intranet",
    "logo": "path",
    "action": "get the GPA",
    "param": [
      {
        "name": "parameter name",
        "type": "string/int",
        "value": "",
      },
      ...
    ],
  },
  "reaction": {
    "service": "slack",
    "logo": "path",
    "reaction": "message",
    "param": [
      {
        "name": "parameter name",
        "type": "string/int",
        "value": "",
      },
      ...
    ]
  }
}
```

### Add an applet

Method: **`POST`**

URL: `API_URL/applets/${id}/add`

```json
{
  "user_id": "ARYUHGFDSDFTRSJDS",
  "action": {
    "service": "intranet",
    "action": "get the GPA",
    "param": [
      {
        "name": "parameter name",
        "type": "string/int",
        "value": "",
      },
      ...
    ],
  },
  "reaction": {
    "service": "slack",
    "logo": "path",
    "reaction": "message",
    "param": [
      {
        "name": "parameter name",
        "type": "string/int",
        "value": "",
      },
      ...
    ]
  }
}
```

### Activate an applet

Method: **`POST`**

URL: `API_URL/applets/${id}/activate`

```json
{
  "user_id": "qnfkjsqnkndfsjnkjq"
}
```

### Desactivate an applet

Method: **`POST`**

url: `API_URL/applets/${id}/desactivate`

```json
{
  "user_id": "qnfkjsqnkndfsjnkjq"
}
```

### Sync Token

One URL per service.

Method: **`POST`**

URL: `API_URL/services/${serviceName}`

Service names can be:

- github
- intraepitech
- slack
- microsoft

For example : `API_URL`/services/`github`

```json
{
  "user_id": "EZANKLZAZEKNFKL",
  "token": "kjzankenfkjaaf...",
  "refresh": ""
}
```

For the refresh token:

- `""` where there are no refresh-token
- otherwise the `token`

### Get applet by action

Method: **`GET`**

URL: `API_URL/applets/${Service}/${actions}`

```json
[
  {
    "id": "ID",
    "title": "Follow My Progression",
    "description": "Get a message when the GPA ...",
    "color" : "0xffb74093",
    "enable": false,
    "action": {
      "service": "intranet",
      "logo": "path",
      "action": "get the GPA",
      "param": [
        {
          "name": "parameter name",
          "type": "string/int",
          "value": "",
        },
        ...
      ],
    },
    "reaction": {
      "service": "slack",
      "logo": "path",
      "reaction": "message",
      "param": [
        {
          "name": "parameter name",
          "type": "string/int",
          "value": "",
        },
        ...
      ]
    },
  }
  ...
]
```

### Get applet by reaction

Method: **`GET`**

URL: `API_URL/applets/${Service}/${reaction}`

```json
[
  {
    "id": "ID",
    "title": "Follow My Progression",
    "description": "Get a message when the GPA ...",
    "color" : "0xffb74093",
    "enable": false,
    "action": {
      "service": "intranet",
      "logo": "path",
      "action": "get the GPA",
      "param": [
        {
          "name": "parameter name",
          "type": "string/int",
          "value": "",
        },
        ...
      ],
    },
    "reaction": {
      "service": "slack",
      "logo": "path",
      "reaction": "message",
      "param": [
        {
          "name": "parameter name",
          "type": "string/int",
          "value": "",
        },
        ...
      ]
    },
  },
  ...
]
```


### Search for an Applet


Method: **`GET`**

URL : `API_URL/applets/search?s=${stringTosearch}`

```json
[
  {
    "id": "ID",
    "title": "Follow My Progression",
    "description": "Get a message when the GPA ...",
    "color" : "0xffb74093",
    "enable": false,
    "action": {
      "service": "intranet",
      "logo": "path",
      "action": "get the GPA",
      "param": [
        {
          "name": "parameter name",
          "type": "string/int",
          "value": "",
        },
        ...
      ],
    },
    "reaction": {
      "service": "slack",
      "logo": "path",
      "reaction": "message",
      "param": [
        {
          "name": "parameter name",
          "type": "string/int",
          "value": "",
        },
        ...
      ]
    },
  },
  ...
]
```

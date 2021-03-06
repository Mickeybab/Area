# AREA

## Services

- Google Mail
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

## Admin Panel
For manage AREA Users and Admin Users

Default Admin user: `admin`

Default Admin password: `admin`

`AUTHENTICATION AND AUTHORIZATION` Is for Admin Users

`LINK_API` Is for Area Users

## Requests

### Get all the services

Method: **`GET`**

URL: `API_URL/services`

```data
  "user_id=qnfkjsqnkndfsjnkjq"
```

```json
[
  {
    "service": "Github",
    "color" : "0xffb74093",
    "logo": "path",
    "enable": false,
    "sync": true,
  },
  ...
]
```

### Activate a service

Method: **`POST`**

URL: `API_URL/services/${serviceName}/activate`

```data
  "user_id=qnfkjsqnkndfsjnkjq"
```

### Desactivate a service

Method: **`POST`**

URL: `API_URL/services/${serviceName}/desactivate`

```data
  "user_id=qnfkjsqnkndfsjnkjq"
```

### Get all the applets

Method: **`GET`**

URL: `API_URL/applets`

```data
  "user_id=qnfkjsqnkndfsjnkjq"
```

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

```data
  "user_id=qnfkjsqnkndfsjnkjq"
```

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

```data
  "user_id=qnfkjsqnkndfsjnkjq"
```

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

```data
  "user_id=qnfkjsqnkndfsjnkjq"
```

### Desactivate an applet

Method: **`POST`**

url: `API_URL/applets/${id}/desactivate`

```data
  "user_id=qnfkjsqnkndfsjnkjq"
```

### Search for an Applet


Method: **`GET`**

URL : `API_URL/applets/search?s=${stringTosearch}`

```data
  "user_id=qnfkjsqnkndfsjnkjq"
```

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

### Sync Token

One URL per service.

Method: **`POST`**

URL: `API_URL/services/${serviceName}`

Service names can be:

- github
- intraepitech
- slack
- googlemail

For example : `API_URL`/services/`github`

```data
  "user_id"=EZANKLZAZEKNFKL",
  "token=kjzankenfkjaaf...",
  "refresh=zaertytedz"
```

For the refresh token:

- `""` where there are no refresh-token
- otherwise the `token`

### Get applets by service

Method: **`GET`**

URL: `API_URL/applets/${Service}`

```data
  "user_id=qnfkjsqnkndfsjnkjq"
```

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

### Get applet by action

Method: **`GET`**

URL: `API_URL/applets/${Service}/${actions}`

```data
  "user_id=qnfkjsqnkndfsjnkjq"
```

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

```data
  "user_id=qnfkjsqnkndfsjnkjq"
```

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

### Create new user

Methode: **`POST`**

URL: `API_URL/users/create`

```data
  "user_id=qnfkjsqnkndfsjnkjq"
```

### Update new user

Methode: **`POST`**

URL: `API_URL/users/{user_id}`

```data
  "user_id=qnfkjsqnkndfsjnkjq"
```

```json
{
  "name": "a",
  "last_name": "b",
}
```

Methode: **`GET`**

URL: `API_URL/notif`

```data
  "user_id=qnfkjsqnkndfsjnkjq"
```

```json
[{
  "message": "salut le boss"
},
{
  "message": "autre notif"
},
...
]
```
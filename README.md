# AREA

## Services

- Outlook Mail
- Github
- OpenWeather
- ExchangeRateApi
- Slack
- [Intra Epitech]

## Actions / Reactions

### Actions

- Recevoir un Mail
- Recevoir une notif intra
- Une note inférieur à telle valeur
- Un total de credit qui dépasse un objectif
- Un total de GPA qui fluctu en dessous un objectif
- Un total de GPA qui fluctu au dessus un objectif
- Un Commit à été réaliser sur un repo spécifique
- la température Dépasse une certaine température
- la température est inférieur à un seuil
- la valeur d'une monnaie fluctu en dessous d'un seuil
- la valeur d'une monnaie fluctu au dessus d'un seuil
- recevoir une notification Slack

### Reations

- Notifications
- Mails
- Messages

## Requests

### Get toutes les applets activer

url `API_URL/applets`

Method : **`GET`**

```json
[
  {
    "id": "ID",
    "action": "Intra GPA",
    "reaction": "Slack Message",
    "title": "Follow My Progression",
    "description": "Get a message when the GPA ",
    "enable": false,
    "valeurs": [
      {
        "name": "nom du paramètre",
        "type": "string/int",
        "value": "",
        "category": "action/reaction",
      },
      ...
    ]
  },
  ...
]
```

### Get une Applets

url `API_URL/applets/${id}`

Method : **`GET`**

```json
{
  "id": "ID",
  "action": "Intra GPA",
  "reaction": "Slack Message",
  "title": "Follow My Progression",
  "description": "Recevoir un messages lorsque mon GPA dépasse une certaines valeurs",
  "enable": false,
  "valeurs": [
    {
      "name": "nom du paramètre",
      "type": "string/int",
      "value": "",
      "category": "action/reaction",
    },
    ...
  ]
}
```

### Activer un Applets

url : `API_URL/applets/${id}/activate`

Method : **`GET`**

```json
{
  "user_id": "ARYUHGFDSDFTRSJDS",
  "valeurs": [
    {
      "name": "nom du paramètre",
      "type": "string/int",
      "value": "",
      "category": "action/reaction",
    },
    ...
  ]
}
```

### Désactiver un Applets

Method : **`POST`**

url : `API_URL/applets/${id}/desactivate`

```json
{
  "user_id": "qnfkjsqnkndfsjnkjq"
}
```

### Sync Token

Un url par services

`API_URL/services/${serviceName}`

Les services name peuvent être les suivants

- github
- intraepitech
- slack
- microsoft

par example : `API_URL`/services/`github`

Method : **`POST`**

```json
{
  "user_id": "EZANKLZAZEKNFKL",
  "token": "kjzankenfkjaaf...",
  "refresh": ""
}
```

For the refresh refresh:

- `""` where there are no refresh-token
- otherwise the `token`

### Get les applets en fonction des actions

`API_URL/applets/${Service}/${Actions}`

Method : **`GET`**

```json
[
  {
    "id": "ID",
    "action": "Intra GPA",
    "reaction": "Slack Message",
    "title": "Follow My Progression",
    "description": "Recevoir un messages lorsque mon GPA dépasse une certaines valeurs",
    "enable": false,
    "valeurs": [
      {
        "name": "nom du paramètre",
        "type": "string/int",
        "value": "",
        "category": "action/reaction",
      },
      ...
    ]
  },
  ...
]
```

### Get les applets en fonction des Reactions

`API_URL/applets/${Service}/${Reaction}`

Method : **`GET`**

```json
[
  {
    "id": "ID",

    "action": "Intra GPA",
    "reaction": "Slack Message",
    "title": "Follow My Progression",
    "description": "Recevoir un messages lorsque mon GPA dépasse une certaines valeurs",
    "enable": false,
    "valeurs": [
      {
        "name": "nom du paramètre",
        "type": "string/int",
        "value": "",
        "category": "action/reaction",
      },
      ...
    ]
  },
  ...
]
```

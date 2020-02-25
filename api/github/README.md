# **Epitech Currency API**

## **Version**

v1.0.0

## **Author**

- florent.poinsard@epitech.eu


## **Tech choice**

This API is a NodeJS based application.

Why NodeJS? For this API we used a library that partially wraps GitHub API, this library is in Node JS, so here is why we used node js.

Node JS allows us to use thread and async opération very easily.

## **Description**

The Currency API enable developers to uses the wrapper of the [currency API](https://exchangeratesapi.io) we provide on pedafy.com.

This API uses the Richardson Maturity Model, more info [here](https://martinfowler.com/articles/richardsonMaturityModel.html).

## **Routes**

| Action | Method | Route |
| ---- | ---- | ---- |
| Get the last issues of a repo | `GET` | `/v1/github/:owner/:repo/last/issue` |
| Get the last pulls of a repo | `GET` | `/v1/github/:owner/:repo/last/pull` |
| Get the last commit of a repo | `GET` | `/v1/github/:owner/:repo/last/commit` |
| Merge a Pull Request | `GET` | `/v1/github/:owner/:repo/merge/:pr` |
| Get the last comments on a Pull Request | `GET` | `/v1/github/:owner/:repo/:pr/commit` |


### ***Development URL***

- http://localhost:9004/v1/github ...

## **OAuth 2**

In order to use this API you need the OAuth Token.

Add this in the header of each request to our API :

```json
{
    "Authorization": "$MY_TOKEN"
}
```

## **Routes description**

### **Get the last issues of a repo**

Request type: `GET`.

URL: `/v1/github/:owner/:repo/last/issue`.

`repo` is the name of the repository.

`owner` is the github user who's owner of the `repo`.

Here is an example of a **response**:
```json
{
    "status": "success",
    "code": 200,
    "data": {
        "name": "Call to currency API in currency service",
        "url": "https://github.com/frouioui/dashboard-epitech/issues/115",
        "number": 115
    }
}
```

____
### **Get the last pulls of a repo**

Request type: `GET`.

URL: `/v1/github/:owner/:repo/last/issue`.

`repo` is the name of the repository.

`owner` is the github user who's owner of the `repo`.

Here is an example of a **response**:
```json
{
    "status": "success",
    "code": 200,
    "data": {
        "name": "Bump lodash.template from 4.4.0 to 4.5.0 in /app",
        "url": "https://api.github.com/repos/frouioui/dashboard-epitech/pulls/65",
        "number": 65
    }
}
```

____
### **Get the last commit of a repo**

Request type: `GET`.

URL: `/v1/github/:owner/:repo/last/commit`.

`repo` is the name of the repository.

`owner` is the github user who's owner of the `repo`.

Here is an example of a **response**:
```json
{
    "status": "success",
    "code": 200,
    "data": {
        "size": 11,
        "commits": [
            {
                "message": "[ADD] SearchBAR to explore page",
                "author": "Julien Ollivier",
                "url": "https://api.github.com/repos/frouioui/AREA/git/commits/e60ffeb83d1917b8901af28e64a2d820d1bd40a1",
                "date": "2020-01-19T19:43:40Z"
            }
        ]
    }
```

____
### **Merge a Pull Request**

Request type: `GET`.

URL: `/v1/github/:owner/:repo/merge/:pr`.

`repo` is the name of the repository.

`owner` is the github user who's owner of the `repo`.

`pr` refers to the number of the Pull Request

Here is an example of a **response**:
```json
{
    "status": "success",
    "code": 200,
    "data": {
        "sha": "b7aa0c1a840cb452b1b8a881f43bcd0536379c32",
        "merged": true,
        "message": "Pull Request successfully merged"
    }
}
```

____
### **Get the last comments on a Pull Request**

Request type: `GET`.

URL: `/v1/github/:owner/:repo/:pr/last/commit`.

`repo` is the name of the repository.

`owner` is the github user who's owner of the `repo`.

`pr` refers to the number of the Pull Request

Here is an example of a **response**:
```json
{
    "status": "success",
    "code": 200,
    "data": {
        "size": 11,
        "commits": [
            {
                "message": "[ADD] Adding scroll to fix bottom overflow",
                "date": "2020-02-05T10:26:24Z",
                "author": "cecile.cadoul@epitech.eu"
            }
        ]
    }
```
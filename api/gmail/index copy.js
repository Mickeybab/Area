const fs = require('fs');
const readline = require('readline');
const {google} = require('googleapis');
const express = require('express');
const app = express();

app.get('/emails', (req, res) => {
    getclient(req.query.access_token, lastMessages, res);
});

app.listen(3000, function () {
    console.log('Example app listening on port 3000!')
});


// If modifying these scopes, delete token.json.
const SCOPES = ['https://www.googleapis.com/auth/gmail.readonly'];
// The file token.json stores the user's access and refresh tokens, and is
// created automatically when the authorization flow completes for the first
// time.
const TOKEN_PATH = 'token.json';

// Load client secrets from a local file.

function getclient(token, callback, res) {
    return fs.readFile('credentials_Gmail.json', (err, content) => {
        if (err)
            return console.log('Error loading client secret file:', err);
        // Authorize a client with credentials, then call the Gmail API.
        return authorize(JSON.parse(content), token, callback, res);
    });
}

/**
 * Create an OAuth2 client with the given credentials, and then execute the
 * given callback function.
 * @param {Object} credentials The authorization client credentials.
 * @param {function} callback The callback to call with the authorized client.
 */
function authorize(credentials, ourToken, callback, res) {
  const {client_secret, client_id, redirect_uris} = credentials.installed;
  const oAuth2Client = new google.auth.OAuth2(
      client_id, client_secret, redirect_uris[0]);

  // Check if we have previously stored a token.
  return fs.readFile(TOKEN_PATH, (err, token) => {
    if (err) return res.send("An Error occur");
    console.log(JSON.parse(token));
    const newToken = JSON.parse(token);
    newToken.access_token = ourToken;
    oAuth2Client.setCredentials(newToken);
    console.log(oAuth2Client);
    return callback(oAuth2Client, res);
  });
}

/**
 * Lists the labels in the user's account.
 *
 * @param {google.auth.OAuth2} auth An authorized OAuth2 client.
 */
function lastMessages(auth, resquest) {
  const gmail = google.gmail({version: 'v1', auth});
  return gmail.users.messages.list({
    userId: 'me', maxResults: 1
  }, async (err, res) => {
    if (err) return console.log('The API returned an error: ' + err);
    const labels = res.data;
    console.log(labels);
    const messages = await Promise.all(labels.messages.map(async (message) => {
        return (await gmail.users.messages.get({userId: 'me', id: message.id})).data;
    }));
    console.log(messages);
    resquest.send(JSON.stringify(messages));
    return res.data;
  });
}

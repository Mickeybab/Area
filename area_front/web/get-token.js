// We are closing the window is a window opened
// but just before we send the href to the opener window
// to be able to get `code` when loging on oauth2 flow
if (window.opener) {
    window.opener.postMessage(window.location.href, "*");
    window.close();
}

// Function to handle the missing
// compatibility between dart and js function
var functionImportedInDart = function jsReceiveMessage (event) {
    dartReceiveMessage(event.data);
}

var url = window.location;
var code = null;
var notloged = false;
if (window.opener) {
    var code = new URLSearchParams(url.search).get('code');
    console.log(window.location);
    window.opener.postMessage(code, "*");
    window.close();
}


console.log(code);
var receiveMessage = function (event) {
    console.log(event);
    code = event.data;
}
function openWindow(url, title, w, h) {
    window.removeEventListener('message', receiveMessage);
    var popup = window.open(url, title,
      'width='+w+',height='+h+',modal=yes,resizable=no,toolbar=no,menubar=no,'+
      'scrollbars=no, alwaysRaise=yes'
    );
    popup.onclose = () => {
        setTimeout(() => {
            notloged = true;
            console.log("Pas log");
        }, 3000);
    }
    popup.resizeBy(0, 0.50);
    popup.focus();
    window.addEventListener('message', receiveMessage);

}

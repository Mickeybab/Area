
function sendNotification(message) {
    Notification.requestPermission(function (status) {
        new Notification("AREA", { body: message }); // this also shows the notification
    });
}

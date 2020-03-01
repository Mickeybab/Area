mv ./lib/backend/Notification.noWeb.dart ./lib/backend/Notification.dart
/usr/local/flutter/bin/flutter build apk
cp build/app/outputs/apk/release/app-release.apk /statics
sleep 1000000000
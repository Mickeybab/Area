# **AREA Epitech front**

A new Flutter project.

## **Dependency**

- `flutter channel beta`
- `Google Account -> Firebase Project`

if you want help to config channel beta [here](https://flutter.dev/docs/get-started/web)

## **Set Up**

- Create a **Firebase Project**

### **Android**

- On the Firebase console's project overview page, add an **Android App** to the Project
- Download **google-service.json** at `./android/app/src/`
- Connect Your Phone / Create a emulator

### **Web**

- Verify _scripts_ in `./web/index.html` ([Add Firebase to your JavaScript project](https://firebase.google.com/docs/web/setup#from-the-cdn))
- Add an `init-firebase.js` at `./web/` which contain :

```
  // Your web app's Firebase configuration
 var firebaseConfig = {
     apiKey: "...",
     authDomain: "[YOUR_PROJECT].firebaseapp.com",
     databaseURL: "https://[YOUR_PROJECT].firebaseio.com",
     projectId: "[YOUR_PROJECT]",
     storageBucket: "[YOUR_PROJECT].appspot.com",
     messagingSenderId: "...",
     appId: "1:...:web:...",
     measurementId: "G-..."
 };
 // Initialize Firebase
 firebase.initializeApp(firebaseConfig);
 firebase.analytics();
```

You can find your config value [here](http://support.google.com/firebase/answer/7015592).

### **iOS**

- On the Firebase console's project overview page, add an **iOs App** to the Project
- Using Xcode, open the iOS project `area_front/ios/Runner.xcworkspace`
- Enter your app’s **bundle ID** in the iOS bundle ID field

_Find this **bundle ID** from your open project in XCode. Select the top-level app in the project navigator, then access the `General` tab. The Bundle Identifier value is the iOS bundle ID (for example, `com.yourcompany.ios-app-name`)._

- Click **Register app**.
- Click Download GoogleService-Info.plist to obtain your Firebase iOS config file (`GoogleService-Info.plist`)
- Move the file `GoogleService-Info.plist` into the `Runner/Runner` directory
- Back in the Firebase console setup workflow, click Next to skip the remaining steps

To test your application, you can [set up the iOS simulator](https://flutter.dev/docs/get-started/install/macos#set-up-the-ios-simulator) or/and [use an iOS device](https://flutter.dev/docs/get-started/install/macos#deploy-to-ios-devices).

### **Global**

- Add in `./lib/config.dart` environnement configuration variable :
```
final Map<String, String> config = {
  'API_URL': 'localhost'
  ...YOUR_KEY
}
```
*We will change the way of handle the config file as soon as the issue on [Flutter Global Config](https://github.com/Ephenodrom/Flutter-Global-Config/issues/9) instead of using dart code we will use an assets in json*

----

For this porject in more than `Firebase` you will need your proper API to handle all the APPLET the `routes` needed are described below:

| Action                                                             | Method | Route                         |
| ------------------------------------------------------------------ | ------ | ----------------------------- |
| Get all the reactions component                                    | `GET`  | `API_URL/reactions`           |
| Get all the reactions component that the user does'nt already have | `GET`  | `API_URL/:userId/suggestions` |
| ...                                                                | ...    | ...                           |

## **Run It**

> _You must do the set up part to be able to run the app !_

List possibles devides using:

```
flutter devices

Pixel 3a XL • 937AX056XB • android-arm64  • Android 10 (API 29)
Chrome      • chrome     • web-javascript • Google Chrome 79.0.3945.117
Web Server  • web-server • web-javascript • Flutter Tools
```

### **Web**

```
$ flutter run -d chrome
```

### **Android**

```
$ flutter run -d 937AX056XB
```

### **iOS**

```
$ open -a Simulator
$ flutter run
```
> If an error occured on compilation, try [this](https://github.com/flutter/flutter/issues/41383#issuecomment-549432413).

## **Help used to realise the project**

### Configuration

- [Environment-Specific Configuration with Flutter](https://flutterigniter.com/env-specific-configuration/)
- [JSON SERIABLE](https://pub.dev/packages/json_serializable#-readme-tab-)
- [Add Firebase to your JavaScript project](https://firebase.google.com/docs/web/setup#from-the-cdn)

### Authentication

- [Firebase authentication & Google sign in using Flutter](https://blog.codemagic.io/firebase-authentication-google-sign-in-using-flutter/)

### UI

- [Flutter - Settings Button (Popup Menu Button)](https://www.youtube.com/watch?v=CpjfR5rG2lM)
- [Layouts](https://flutter.dev/docs/development/ui/layout)

### Architecture

- [Simple app state management](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple)

---

## **Purpose of the Project**

_The objective of this project is to discover the software platform of your choice among Java, C# .Net and mode.js, Flutter, ... to realize a business application that interconnects several external services (such as Epitech intranet, Yammer, Gmail, RSS...) as Reaction components.
It is similar to tools like IFTTT or Zapier._

# Authors

* **[Cecile Cadoul](cecile.cadoul@epitech.eu)**
* **[Julien Ollivier](julien.ollivier@epitech.eu)**

# **AREA Epitech front**

A new Flutter project.


## **Dependency**

- `flutter channel beta`
- `Google Account -> Firebase Project`

if you want help to config channel beta [here](https://flutter.dev/docs/get-started/web)

## **Set Up**

### **Android App**

- Create a **Firebase Project**
- Add an **Android App** to the Project
- Download **google-service.json** at `./android/app/src/`
- Connect Your Phone / Create a emulator


### **Web**

 TODO

### **IOS**

 TODO


### **Global**

- Add in `.env` environnement configuration variable :
    - `API_URL`

For this porject in more than `Firebase` you will need your proper API to handle all the APPLET the `routes` needed are described below :

| Action | Method | Route |
| ---- | ---- | ---- | ---- |
| Get all the reactions component | `GET` | `API_URL/reactions` |
| Get all the reactions component that the user does'nt already have | `GET` | `API_URL/:userId/suggestions` |
| ... | ... | ... |


## **Run It**

*You must do the set up part to be able to run the app !*

List possibles devides using :

```
flutter devices

Pixel 3a XL • 937AX056XB • android-arm64  • Android 10 (API 29)
Chrome      • chrome     • web-javascript • Google Chrome 79.0.3945.117
Web Server  • web-server • web-javascript • Flutter Tools
```

For the *web* version you will have to do :
```
flutter run -d chrome
```

For *Android* :
```
flutter run -d 937AX056XB
```

For *IOS* :
```
flutter run -d `TOFILL` @cecile.cadoule@epitech.eu
```

## **Help used to realise the project**

### Auth
- [Firebase authentication & Google sign in using Flutter](https://blog.codemagic.io/firebase-authentication-google-sign-in-using-flutter/)
### Config
- [Environment-Specific Configuration with Flutter](https://flutterigniter.com/env-specific-configuration/)
- [JSON SERIABLE](https://pub.dev/packages/json_serializable#-readme-tab-)

### UI

- [Flutter - Settings Button (Popup Menu Button)](https://www.youtube.com/watch?v=CpjfR5rG2lM)
- [Layouts](https://flutter.dev/docs/development/ui/layout)

### Architecture
- [Simple app state management](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple)

## **Purpose of the Project**

*The objective of this project is to discover the software platform of your choice among Java, C# .Net and mode.js, Flutter, ... to realize a business application that interconnects several external services (such as Epitech intranet, Yammer, Gmail, RSS...) as Reaction components.
It is similar to tools like IFTTT or Zapier.*


# Authors

- cecile.cadoul@epitech.eu
- julien.ollivier@epitech.eu
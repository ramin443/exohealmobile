# exohealandroid

This is the mobile app that supplements the Exoheal robotic exoskeleton device used for hand paralysis recovery. Patients are able to connect to the device via an HC-05 BT module mounted on the exoskeleton. Additionally, patients get exercise recommendations based on their recovery progress over time. 

Since the availability of the Exoheal device is necessary to fully demonstrate the potential and functionalities of this app, we would suggest any viewers to have a look at this in terms of the UI placement of functional aspects as well as the code implementation to get an understanding of the underlying architecture.

## Code Readability
The State Management solution used for this implementation is GetX supplied by the get: ^4.6.5 package from pub.dev. To navigate to specific sections and dart files within this repository, please refer to the locations and their corresponding objectives below:
1. lib/screens: All UI screens with controllers wrapped over them. Streamcontrollers and Builders are not isolated yet so one shall expect it to exist teogether with the UI files.
2. lib/getxcontroller: All GetX state management controllers can be found within this folders.
3. lib/datamodels: All Classes and Data Models needed within the app can be located here.
4. lib/constants: All const Strings and Colors used to resolve code redundancies cn be found here. 

The app is using the following Flutter and Dart versioning:
Flutter 3.19.6 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 54e66469a9 (3 weeks ago) • 2024-04-17 13:08:03 -0700
Engine • revision c4cd48e186
Tools • Dart 3.3.4 • DevTools 2.31.1

The versions have to be the same or within a particular range for the app to compile since some dependencies use recent Dart versions after 2.30.0 or later.

The following packages have been implemented with the specified versioning:

  cupertino_icons: ^1.0.2
  intl: ^0.17.0
  sqflite: ^2.2.7
  feather_icons: ^1.2.0
  get: ^4.6.5
  rive: ^0.10.4
  flutter_svg: ^2.0.5
  email_validator: ^2.1.17

  firebase_core: ^2.10.0
  firebase_auth: ^4.4.2
  cloud_firestore: ^4.5.2
  firebase_remote_config: ^4.4.4
  firebase_messaging: ^14.9.1
  flutter_gemma: ^0.1.4

  fl_chart: ^0.36.4
  audio_video_progress_bar: ^1.0.1
  sleek_circular_slider: ^2.0.1
  path_provider: ^2.0.14
  charts_flutter: ^0.12.0
  image_picker: ^0.8.4+5
  simple_animations: ^5.0.2
  flutter_bluetooth_serial: ^0.4.0
  permission_handler: ^11.0.1

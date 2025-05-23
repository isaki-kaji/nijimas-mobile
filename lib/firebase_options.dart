// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyALOsVBRztW1457Y3Ny8fKxPzN1o4C7yOc',
    appId: '1:347460974318:web:c4c99b79e9a66a8346e5ff',
    messagingSenderId: '347460974318',
    projectId: 'nijimas-2832c',
    authDomain: 'nijimas-2832c.firebaseapp.com',
    storageBucket: 'nijimas-2832c.appspot.com',
    measurementId: 'G-SQCJ0940ZC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCSGGDIf7_AxRKYzOb5xGlWiAE7VaboWYI',
    appId: '1:347460974318:android:77983887c728f8c546e5ff',
    messagingSenderId: '347460974318',
    projectId: 'nijimas-2832c',
    storageBucket: 'nijimas-2832c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBfa5IqBxta4Rb1G9G1ku4lE_YLkQF2qIM',
    appId: '1:347460974318:ios:d460088957e0770a46e5ff',
    messagingSenderId: '347460974318',
    projectId: 'nijimas-2832c',
    storageBucket: 'nijimas-2832c.appspot.com',
    androidClientId: '347460974318-8f5j9ghe3k517b1epi2hom9mcrgmhl39.apps.googleusercontent.com',
    iosClientId: '347460974318-eh96e0k65fkicknnn2iqqpsmo6jvpenp.apps.googleusercontent.com',
    iosBundleId: 'com.example.nijimas',
  );

}
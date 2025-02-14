// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBZ7vB06h_a0Nv0hQ4BEzxeoBxdFJ9kabQ',
    appId: '1:109526910363:web:2891be803a772d9b700d3e',
    messagingSenderId: '109526910363',
    projectId: 'notification-b4406',
    authDomain: 'notification-b4406.firebaseapp.com',
    storageBucket: 'notification-b4406.appspot.com',
    measurementId: 'G-K8HTNQM24C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBwxsAAAfYt01gdHmbOJpdlJjQTq9jg-nE',
    appId: '1:109526910363:android:db90245887ff19d3700d3e',
    messagingSenderId: '109526910363',
    projectId: 'notification-b4406',
    storageBucket: 'notification-b4406.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyATQylxlAEHZRJm4Ufev3rBguXX8Sadda0',
    appId: '1:109526910363:ios:72cca1fb84bf8556700d3e',
    messagingSenderId: '109526910363',
    projectId: 'notification-b4406',
    storageBucket: 'notification-b4406.appspot.com',
    iosBundleId: 'com.example.pizzaHutAdmin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyATQylxlAEHZRJm4Ufev3rBguXX8Sadda0',
    appId: '1:109526910363:ios:72cca1fb84bf8556700d3e',
    messagingSenderId: '109526910363',
    projectId: 'notification-b4406',
    storageBucket: 'notification-b4406.appspot.com',
    iosBundleId: 'com.example.pizzaHutAdmin',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBZ7vB06h_a0Nv0hQ4BEzxeoBxdFJ9kabQ',
    appId: '1:109526910363:web:c53be5b6cff24ed2700d3e',
    messagingSenderId: '109526910363',
    projectId: 'notification-b4406',
    authDomain: 'notification-b4406.firebaseapp.com',
    storageBucket: 'notification-b4406.appspot.com',
    measurementId: 'G-BQ0ELVJLHF',
  );
}

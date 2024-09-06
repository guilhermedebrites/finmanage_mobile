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
    apiKey: 'AIzaSyBLw2m0mqo1UY3gdSrMMGKkIP-aAf9-MeQ',
    appId: '1:984673865110:web:99d38dfd7b0b2c9e53e1b7',
    messagingSenderId: '984673865110',
    projectId: 'finmanage-ecdfc',
    authDomain: 'finmanage-ecdfc.firebaseapp.com',
    storageBucket: 'finmanage-ecdfc.appspot.com',
    measurementId: 'G-7DP625TE53',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDD8j_aoL59P4EFFQKpXLm-Xg3yYG-J5bQ',
    appId: '1:984673865110:android:03d938410cbf9da553e1b7',
    messagingSenderId: '984673865110',
    projectId: 'finmanage-ecdfc',
    storageBucket: 'finmanage-ecdfc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDS11Ava9TKkEFy3AW0HiT9tgI9C6WZLTk',
    appId: '1:984673865110:ios:2a0933f480bce31f53e1b7',
    messagingSenderId: '984673865110',
    projectId: 'finmanage-ecdfc',
    storageBucket: 'finmanage-ecdfc.appspot.com',
    iosBundleId: 'com.example.finmanageMobile',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDS11Ava9TKkEFy3AW0HiT9tgI9C6WZLTk',
    appId: '1:984673865110:ios:2a0933f480bce31f53e1b7',
    messagingSenderId: '984673865110',
    projectId: 'finmanage-ecdfc',
    storageBucket: 'finmanage-ecdfc.appspot.com',
    iosBundleId: 'com.example.finmanageMobile',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBLw2m0mqo1UY3gdSrMMGKkIP-aAf9-MeQ',
    appId: '1:984673865110:web:4430d2cc6bcb48ed53e1b7',
    messagingSenderId: '984673865110',
    projectId: 'finmanage-ecdfc',
    authDomain: 'finmanage-ecdfc.firebaseapp.com',
    storageBucket: 'finmanage-ecdfc.appspot.com',
    measurementId: 'G-8SKT5Y8JVH',
  );
}

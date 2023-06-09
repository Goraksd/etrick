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
        return macos;
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
    apiKey: 'AIzaSyB_qdb3a1BgecZNO6HJaokwFz__uAxmSXk',
    appId: '1:235794776312:web:222119ddcd02856a2b7b0d',
    messagingSenderId: '235794776312',
    projectId: 'etrick-99a39',
    authDomain: 'etrick-99a39.firebaseapp.com',
    storageBucket: 'etrick-99a39.appspot.com',
    measurementId: 'G-887E3VK6D5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCSpI8eBsyFIEdt-TsX7LwlWf2yeV1F1t0',
    appId: '1:235794776312:android:58327c7f4ad81a652b7b0d',
    messagingSenderId: '235794776312',
    projectId: 'etrick-99a39',
    storageBucket: 'etrick-99a39.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAdGBE5fKVN83qS5BRbtiBrM4ZWoEt3_Q4',
    appId: '1:235794776312:ios:9bf6ec0eb4ced4352b7b0d',
    messagingSenderId: '235794776312',
    projectId: 'etrick-99a39',
    storageBucket: 'etrick-99a39.appspot.com',
    iosBundleId: 'com.example.etrick',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAdGBE5fKVN83qS5BRbtiBrM4ZWoEt3_Q4',
    appId: '1:235794776312:ios:9d0130bd7401d73d2b7b0d',
    messagingSenderId: '235794776312',
    projectId: 'etrick-99a39',
    storageBucket: 'etrick-99a39.appspot.com',
    iosBundleId: 'com.example.etrick.RunnerTests',
  );
}

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
    apiKey: 'AIzaSyCugmZcWoD6zchdT-87rlMsrEoU9GTFcKI',
    appId: '1:499279572214:web:27b06cb34735c6da2d10d7',
    messagingSenderId: '499279572214',
    projectId: 'mikail-firebase',
    authDomain: 'mikail-firebase.firebaseapp.com',
    storageBucket: 'mikail-firebase.appspot.com',
    measurementId: 'G-0Q68RBYJXG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBzk-jY3iOhWxxJj2mef3dtbAsoZQN38YI',
    appId: '1:499279572214:android:16469be9188167982d10d7',
    messagingSenderId: '499279572214',
    projectId: 'mikail-firebase',
    storageBucket: 'mikail-firebase.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAovD4mvhxa9PlyKHWs1Pn5cutsZw_GFX4',
    appId: '1:499279572214:ios:a3976b85ea0d13112d10d7',
    messagingSenderId: '499279572214',
    projectId: 'mikail-firebase',
    storageBucket: 'mikail-firebase.appspot.com',
    iosBundleId: 'com.example.uasmikail',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAovD4mvhxa9PlyKHWs1Pn5cutsZw_GFX4',
    appId: '1:499279572214:ios:8548493ecb7170d62d10d7',
    messagingSenderId: '499279572214',
    projectId: 'mikail-firebase',
    storageBucket: 'mikail-firebase.appspot.com',
    iosBundleId: 'com.example.uasmikail.RunnerTests',
  );
}
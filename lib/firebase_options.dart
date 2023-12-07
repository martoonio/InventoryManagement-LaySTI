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
    apiKey: 'AIzaSyAEtTga2vCrB2s9J2OfQNPrZzS4u7neiCs',
    appId: '1:475934450054:web:c15425531c2c9782510c07',
    messagingSenderId: '475934450054',
    projectId: 'layanansti-85ac5',
    authDomain: 'layanansti-85ac5.firebaseapp.com',
    storageBucket: 'layanansti-85ac5.appspot.com',
    measurementId: 'G-3F2XDC46T7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJpwF51hIJe60kx0DVsBnVAx5zLnRypho',
    appId: '1:475934450054:android:233d331dab10ee53510c07',
    messagingSenderId: '475934450054',
    projectId: 'layanansti-85ac5',
    storageBucket: 'layanansti-85ac5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDZOVJVKOcp435mASAakxLUbyWU3MMLSDU',
    appId: '1:475934450054:ios:10492d64773ee453510c07',
    messagingSenderId: '475934450054',
    projectId: 'layanansti-85ac5',
    storageBucket: 'layanansti-85ac5.appspot.com',
    iosBundleId: 'com.example.lasti',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDZOVJVKOcp435mASAakxLUbyWU3MMLSDU',
    appId: '1:475934450054:ios:fa33a614fc71bd0b510c07',
    messagingSenderId: '475934450054',
    projectId: 'layanansti-85ac5',
    storageBucket: 'layanansti-85ac5.appspot.com',
    iosBundleId: 'com.example.lasti.RunnerTests',
  );
}
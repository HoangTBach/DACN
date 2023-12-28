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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAg1FIDd2DhWSuq1MVkvVgRZ1yaeYmlUm0',
    appId: '1:807832347592:android:034e7adc8aeffb493a56fd',
    messagingSenderId: '807832347592',
    projectId: 'social-app-33',
    storageBucket: 'social-app-33.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBsb01GXTDhdt6R72jEUujrbIOKhc4wvSQ',
    appId: '1:807832347592:ios:5626a66244d8e5163a56fd',
    messagingSenderId: '807832347592',
    projectId: 'social-app-33',
    storageBucket: 'social-app-33.appspot.com',
    androidClientId: '807832347592-dqi44qg1l7h8lsn839ieebv57j5mro8t.apps.googleusercontent.com',
    iosClientId: '807832347592-p5bkhl51he6qjgohljioo139i35kgfcj.apps.googleusercontent.com',
    iosBundleId: 'com.example.socialApp',
  );
}
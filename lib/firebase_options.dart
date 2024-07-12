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
    apiKey: 'AIzaSyDLqvBoTNg7ty-RkhEZ-h_tsUyq7s3nmCY',
    appId: '1:204918764565:web:fedfedc1d49262e0228a1c',
    messagingSenderId: '204918764565',
    projectId: 'chat-web-1a6a3',
    authDomain: 'chat-web-1a6a3.firebaseapp.com',
    storageBucket: 'chat-web-1a6a3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-51hgYToZFlguNd-HodLlM8xOQVPqX_I',
    appId: '1:204918764565:android:00be42318d422603228a1c',
    messagingSenderId: '204918764565',
    projectId: 'chat-web-1a6a3',
    storageBucket: 'chat-web-1a6a3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA5paajE1Y7YFCG3H7AqJ1iyAmFG1ZNn7Y',
    appId: '1:204918764565:ios:08c6239308472709228a1c',
    messagingSenderId: '204918764565',
    projectId: 'chat-web-1a6a3',
    storageBucket: 'chat-web-1a6a3.appspot.com',
    iosBundleId: 'com.example.chatServerMechineTest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA5paajE1Y7YFCG3H7AqJ1iyAmFG1ZNn7Y',
    appId: '1:204918764565:ios:08c6239308472709228a1c',
    messagingSenderId: '204918764565',
    projectId: 'chat-web-1a6a3',
    storageBucket: 'chat-web-1a6a3.appspot.com',
    iosBundleId: 'com.example.chatServerMechineTest',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDLqvBoTNg7ty-RkhEZ-h_tsUyq7s3nmCY',
    appId: '1:204918764565:web:abd1c52f1c7bc353228a1c',
    messagingSenderId: '204918764565',
    projectId: 'chat-web-1a6a3',
    authDomain: 'chat-web-1a6a3.firebaseapp.com',
    storageBucket: 'chat-web-1a6a3.appspot.com',
  );
}

// Main file for the FlutterChat app
//Package imports and Firebase initialization
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Flutter screen imports
import 'package:chat_app/screens/auth.dart';
import 'package:chat_app/screens/chat.dart';
import 'package:chat_app/screens/splash.dart';

// ------------------------------------------------
// * At this time the other features that are not working are:
// * - FirebaseStorage
// * - Firestore (Cloud Firestore)
// * - Push notifications

// ! Lectures are not updated with the proper instructions for the new Firebase packages and unable to test parts of the app.
// ! The app is not fully functional and parts of the code is not working as expected.

//  Todo: Update the code to work with the new Firebase packages as the documentation provides, as well as push notifications.
//  ------------------------------------------------
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 63, 17, 177)),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }

          if (snapshot.hasData) {
            return const ChatScreen();
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}

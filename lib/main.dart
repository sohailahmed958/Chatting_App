import 'package:chatting_app/screens/auth_screen.dart';
import 'package:chatting_app/screens/chat_screen.dart';
import 'package:chatting_app/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
        future: _initialization,
        builder: (context, appSnapshot) {
          return MaterialApp(
            title: 'FlutterChat',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                color: Colors.pink, //<-- SEE HERE
              ),
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.pink, secondary: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: appSnapshot.connectionState != ConnectionState.done
                ? const SplashScreen()
                : StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (ctx, userSnapshot) {
                      // if (userSnapshot.connectionState == ConnectionState.waiting) {
                      //   return const SplashScreen();
                      // }
                      if (userSnapshot.hasData) {
                        return const ChatScreen();
                      }
                      return const AuthScreen();
                    }),
          );
        });
  }
}

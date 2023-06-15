import 'package:chatting_app/widgets/chat/messages.dart';
import 'package:chatting_app/widgets/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //FirebaseMessaging fbm = FirebaseMessaging.instance;
  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission();
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print(message);
      }
      return;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (kDebugMode) {
        print(message);
      }
      return;
    });
    fbm.subscribeToTopic('chat');
    //initFirebaseMessaging();
  }

/*
  Future<void> initFirebaseMessaging() async {
    await fbm.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("onMessage: $message");
      }
      // Handle the received message while the app is in the foreground
    });
    FirebaseMessaging.onBackgroundMessage(
        (_firebaseMessagingBackgroundHandler));

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("onMessageOpenedApp: $message");
      }
      // Handle the tapped notification when the app is in the background
    });
    fbm.subscribeToTopic('chat');
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    //await Firebase.initializeApp();
    if (kDebugMode) {
      print("Handling a background message: ${message.messageId}");
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterChat'),
        actions: [
          DropdownButton(
              underline: Container(),
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    child: const Row(
                      children: [
                        Icon(Icons.exit_to_app),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Logout'),
                      ],
                    ),
                  ),
                )
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              })
        ],
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: const Column(
          children: [Expanded(child: Messages()), NewMessage()],
        ),
      ),
    );
  }
}

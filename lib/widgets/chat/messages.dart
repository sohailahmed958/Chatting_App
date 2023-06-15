import 'package:chatting_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});
  /* Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }*/

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder<User?>(
    //     future: getCurrentUser(),
    //     builder: (ctx, futureSnapshot) {
    //       if (futureSnapshot.connectionState == ConnectionState.waiting) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //       final currentUser = futureSnapshot.data;
    //       if (currentUser == null) {
    //         // Handle the case where the user is not authenticated
    //         return const Text('User not authenticated');
    //       }

    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        stream: //FirebaseFirestore.instance,
            FirebaseFirestore.instance
                .collection('chat')
                .orderBy('createdAt', descending: true)
                .snapshots(),
        builder: (ctx, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatDocs = chatSnapshot.data?.docs;
          return ListView.builder(
            reverse: true,
            itemCount: chatDocs?.length,
            itemBuilder: (ctx, index) => MessageBubble(
              chatDocs?[index].data()['text'],
              chatDocs?[index].data()['username'],
              chatDocs?[index].data()['userImage'],
              chatDocs?[index].data()['userId'] == user?.uid,
              key: ValueKey(chatDocs?[index].id),
            ),
          );
          //   ListView.builder(
          //       reverse: true,
          //       itemCount: chatDocs?.length,
          //       itemBuilder: (ctx, index) => MessageBubble(
          //             chatDocs?[index]['text'],
          //             chatDocs?[index]['username'],
          //             chatDocs?[index]['userImage'],
          //             chatDocs?[index]['userId'] == currentUser.uid,
          //             key: ValueKey(chatDocs?[index].id),
          //           ));
          // });
        });
  }
}

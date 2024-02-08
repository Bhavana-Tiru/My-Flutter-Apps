import 'package:chat_app/widget/msg_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});
  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
      // If want to use it to listen to a stream
      //of messages so that whenever a new message is submitted
      // it's automatically loaded and displayed here.
      // And we can use Stream Builder here because Firebase
      // and these Firebase packages support this stream concept.
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      //it will set
      // up a listener which automatically listens
      // to this remote database and there to the chat collection.
      // And whenever a new document is added here
      // it'll automatically notify our app here
      // or this Firebase package will automatically be made aware
      // of that to be precise.The trigger builder
      builder: (ctx, chatsnapshot) {
        if (chatsnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!chatsnapshot.hasData || chatsnapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No messages found.'),
          );
        }

        if (chatsnapshot.hasError) {
          return const Center(
            child: Text('Something went wrong....'),
          );
        }

        final loadedMessages = chatsnapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.only(
            bottom: 40,
            left: 13,
            right: 13,
          ),
          reverse: true, //List goes from bottom to top
          itemCount: loadedMessages.length,
          itemBuilder: (ctx, index) {
            final chatMessages = loadedMessages[index].data();
            final nextChatMessage = index + 1 < loadedMessages.length
                ? loadedMessages[index + 1].data()
                : null;
            final currentmessageUserId = chatMessages['userId'];
            final nextMessageUserId =
                nextChatMessage != null ? nextChatMessage['userId'] : null;

            final nextUserIsSame = nextMessageUserId == currentmessageUserId;

            if (nextUserIsSame) {
              return MessageBubble.next(
                message: chatMessages['text'],
                isMe: authenticatedUser.uid == currentmessageUserId,
              );
            } else {
              return MessageBubble.first(
                  userImage: chatMessages['userImage'],
                  username: chatMessages['username'],
                  message: chatMessages['text'],
                  isMe: authenticatedUser.uid == currentmessageUserId);
            }
          },
        );
      },
    );
  }
}

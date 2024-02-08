import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/widget/chat_msg.dart';
import 'package:chat_app/widget/new_msg.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setUpPushNotification() async {
    final fcm = FirebaseMessaging.instance;
    // asks the user for permission
    // to receive and handle push notifications.
    // requestPermission returns a future.
    await fcm.requestPermission();

    fcm.subscribeToTopic('chat');

    // is the address of the device
    // on which your app is running.
    // And it's this address which you would need
    // to target this specific device.
    // final token = await fcm.getToken();
    // print(
    //     token); // u could send this token (via HTTp or the Firestore SDK to a backend)
  }

  @override
  // Called when this object is inserted into the tree.
  // The framework will call this method exactly once for each State object it creates.
  void initState() {
    super.initState();
    setUpPushNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: const Column(
        children: [
          Expanded(
            child: ChatMessages(),
          ),
          NewMessage(),
        ],
      ),
    );
  }
}

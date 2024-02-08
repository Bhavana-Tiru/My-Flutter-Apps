import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() {
    // TODO: implement createState
    return _NewMessage();
  }
}

class _NewMessage extends State<NewMessage> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage() async {
    final eneteredmessage = _messageController.text;

    if (eneteredmessage.trim().isEmpty) {
      return;
    }

    FocusScope.of(context).unfocus();
    // closes any keyboard by removing the focus from the i/p field.
    _messageController.clear();
    // clear is used to set back the value to empty after sending the value.

    final user = FirebaseAuth.instance.currentUser!;
    // FirebaseAuth gives access to current user that has logged in

    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    //get gives a http requests
    //Firebase to retrieve the data in thid doc(user.uid) in this collection collection('users').

    //send to firebase
    FirebaseFirestore.instance.collection('chat').add({
      'text': eneteredmessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData
          .data()!['username'], //data: Contains all the data of this document.
      'userImage': userData.data()!['image_url'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(labelText: 'send message...'),
            ),
          ),
          IconButton(
            onPressed: _submitMessage,
            color: Theme.of(context).colorScheme.primary,
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}

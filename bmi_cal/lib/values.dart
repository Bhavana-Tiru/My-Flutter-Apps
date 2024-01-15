import 'package:flutter/material.dart';

class Values extends StatefulWidget {
  const Values({super.key});

  @override
  State<Values> createState() {
    return _Values();
  }
}

class _Values extends State<Values> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        child: Text('How tall are you?'),
      ),
    );
  }
}

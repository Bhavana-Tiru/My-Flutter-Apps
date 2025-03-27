import 'package:bmi_cal/age.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: const Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 100),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Age(),
            ],
          ),
        ),
      ),
    );
  }
}

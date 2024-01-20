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
      backgroundColor: Colors.amber[200],
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.all(8)),
          const SizedBox(
            width: 20,
            height: 80,
          ),
          Text(
            'how tall are you?', //'how tall are you? \n (in cm)' :-to asign new line \n is used.
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 121, 90, 3),
              fontSize: 33,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '(in cm)',
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 121, 90, 3),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your height here',
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Age(),
        ],
      ),
    );
  }
}

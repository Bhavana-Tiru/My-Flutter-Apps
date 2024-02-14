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
              // Text(
              //   'how tall are you?', //'how tall are you? \n (in cm)' :-to asign new line \n is used.
              //   style: GoogleFonts.lato(
              //     color: const Color.fromARGB(255, 121, 90, 3),
              //     fontSize: 33,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // Text(
              //   '(in cm)',
              //   style: GoogleFonts.lato(
              //     color: const Color.fromARGB(255, 121, 90, 3),
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              //   child: TextFormField(
              //     decoration: const InputDecoration(
              //       border: UnderlineInputBorder(),
              //       labelText: 'Enter your height here',
              //     ),
              //     onSaved: (onvalue) {

              //     },

              //   ),
              // ),

              Age(),
            ],
          ),
        ),
      ),
    );
  }
}

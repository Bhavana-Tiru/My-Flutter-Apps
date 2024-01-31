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
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // const SizedBox(
            //   width: 20,
            // ),
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Age extends StatelessWidget {
  const Age({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What is your weight ?",
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 121, 90, 3),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '(in kg)',
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 121, 90, 3),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Text(
                "what's your age?",
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 121, 90, 3),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Resultpage extends StatelessWidget {
  Resultpage({super.key, required this.totalbmi});

  final totalbmi;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 223, 206),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 80),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Results',
                style: GoogleFonts.robotoSlab(
                    fontSize: 30,
                    color: const Color.fromARGB(255, 121, 90, 3),
                    fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 30,
              ),
              Image.asset('assets/images/meter.png'),
              const SizedBox(
                height: 30,
              ),
              if (totalbmi < 18.5)
                Text(
                  " Your BMI is $totalbmi,indicating you are Underweight try to maintain a Healthy Weight. Emphasizes vegetables, fruits, whole grains, and fat-free or low-fat dairy products ",
                  style: GoogleFonts.lato(
                      color: const Color.fromARGB(255, 121, 90, 3),
                      fontWeight: FontWeight.w700,
                      fontSize: 25),
                ),
              if (totalbmi > 18.5 && totalbmi < 24.9)
                Text(
                  " Your BMI is $totalbmi,indicating you are Normal Weight try to maintain a Healthy Weight. Tracking your heart health stats can help you meet your heart health goals. ",
                  style: GoogleFonts.lato(
                      color: const Color.fromARGB(255, 121, 90, 3),
                      fontWeight: FontWeight.w700,
                      fontSize: 25),
                ),
              if (totalbmi >= 25 && totalbmi < 29.9)
                Text(
                  " Your BMI is $totalbmi,indicating you are Overweight try to maintain a Healthy Weight. Eating a healthy diet is the key to heart disease prevention.",
                  style: GoogleFonts.lato(
                      color: const Color.fromARGB(255, 121, 90, 3),
                      fontWeight: FontWeight.w700,
                      fontSize: 25),
                ),
              if (totalbmi >= 30 && totalbmi < 1000)
                Text(
                  " Your BMI is $totalbmi,indicating you are Obesity try to maintain a Healthy Weight. Moving more can lower your risk factors for heart disease.",
                  style: GoogleFonts.lato(
                      color: const Color.fromARGB(255, 121, 90, 3),
                      fontWeight: FontWeight.w700,
                      fontSize: 25),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

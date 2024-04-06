import 'package:bmi_cal/resultspage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Age extends StatefulWidget {
  const Age({super.key});

  @override
  State<Age> createState() => _AgeState();
}

class _AgeState extends State<Age> {
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _textFieldController1 = TextEditingController();

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  void dispose() {
    _textFieldController.dispose();
    _textFieldController1.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _textFieldController.text =
        '';
    _textFieldController1.text = '';
  }

  late int _heightValue;
  late int _weightValue;
  int value = 25;
  double bmi = 0.0;

  void _increment() {
    setState(() {
      value = value + 1;
    });
    print(value);
  }

  void _decrement() {
    setState(() {
      value = value - 1;
    });
    print(value);
  }

  void _calculate() {
    double height = double.parse(heightController.text);
    double weight = double.parse(weightController.text);
    double heightInMeters = height / 100; // Convert height to meters
    setState(() {
      bmi = weight / (heightInMeters * heightInMeters);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Resultpage(totalbmi: bmi.ceil()),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        TextFormField(
          controller: heightController,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Enter your height here',
          ),
          keyboardType: TextInputType.number,
          validator: (inputvalue) {
            if (inputvalue == null ||
                inputvalue.isEmpty ||
                int.tryParse(inputvalue) == null ||
                int.tryParse(inputvalue)! < 55) {
              return 'Please enter a valid number';
            }
            return null;

            // int.tryParse(inputvalue)! < 55 ||
            //     int.tryParse(inputvalue)! > 272
          },
          // onSaved: (onvalue) {
          //   _heightValue = int.parse(onvalue!);
          // },
        ),
        const SizedBox(
          height: 20,
        ),
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
        TextFormField(
          controller: weightController,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Enter your weight here',
          ),
          keyboardType: TextInputType.number,
          maxLines: 1,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "what's your age?",
          style: GoogleFonts.lato(
            color: const Color.fromARGB(255, 121, 90, 3),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 95.0, vertical: 15.0),
              decoration: BoxDecoration(
                border: Border.all(
                    width: 2.0,
                    color: const Color.fromARGB(197, 136, 120, 104)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.red,
                      // border: Border.all(
                      //   width: 2.0,
                      //   color: const Color.fromARGB(255, 124, 123, 122),
                      // ),
                    ),
                    child: IconButton(
                      onPressed: _decrement,
                      icon: const Icon(Icons.minimize_outlined),
                      iconSize: 28,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Text(
                    value.toString(),
                    style: const TextStyle(
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      onPressed: _increment,
                      icon: const Icon(Icons.add),
                      iconSize: 28,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          children: [
            ElevatedButton.icon(
              icon:
                  const Icon(Icons.change_circle_outlined, color: Colors.white),
              label: Text(
                'Clear',
                style: GoogleFonts.lato(
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                _textFieldController.clear();
                _textFieldController1.clear();
                setState(() {
                  value = 25;
                });
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 255, 103, 8))),
            ),
            const SizedBox(
              width: 75,
            ),
            ElevatedButton(
              onPressed: _calculate,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 255, 103, 8),
                ),
              ),
              child: Text(
                'Calculate',
                style: GoogleFonts.lato(
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

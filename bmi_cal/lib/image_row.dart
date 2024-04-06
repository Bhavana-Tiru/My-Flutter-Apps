import 'package:bmi_cal/values.dart';
import 'package:flutter/material.dart';

class RowImage extends StatefulWidget {
  const RowImage({super.key});

  @override
  State<RowImage> createState() {
    return _RowImage();
  }
}

class _RowImage extends State<RowImage> {

  @override
  Widget build(BuildContext context) {
    const img1 = 'assets/images/women.png';
    const img2 = 'assets/images/men.png';

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OutlinedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Values()));
          },
          child: Image.asset(
            img1,
            width: 70,
            height: 350,
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Values()));
          },
          child: Image.asset(
            img2,
            width: 70,
            height: 350,
          ),
        ),
      ],
    );
  }
}

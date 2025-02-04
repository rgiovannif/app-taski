import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final String initialText;
  final String secondText;
  final String thirdText;
  final String subTitle;

  const CustomRichText({
    super.key,
    required this.initialText,
    required this.secondText,
    required this.thirdText,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: RichText(
            text: TextSpan(
              text: initialText,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              children: <TextSpan>[
                TextSpan(
                  text: secondText,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: thirdText,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            subTitle,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

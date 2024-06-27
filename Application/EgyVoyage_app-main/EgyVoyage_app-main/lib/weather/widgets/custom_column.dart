import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomColumn extends StatelessWidget {
  const CustomColumn({
    super.key,
    required this.value,
    required this.imagePath,
    required this.text,
  });
  final String value;
  final String imagePath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          imagePath,
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: CustomText(
            value,
            fontSize: 14,
          ),
        ),
        CustomText(
          text,
          fontSize: 12,
        )
      ],
    );
  }
}

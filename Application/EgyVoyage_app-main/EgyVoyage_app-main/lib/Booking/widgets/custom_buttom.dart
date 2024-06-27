import 'package:flutter/material.dart';

import '../Constant/constant.dart';

class CustomButton extends StatefulWidget {
  CustomButton({super.key, required this.text, this.onPressed, this.onpacity});

  String text;
  void Function()? onPressed;
  final double?onpacity ;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: MaterialButton(
        splashColor: Colors.white,
        focusColor: Colors.white,
        // hoverColor: kPrimaryColor,
        color: kPrimaryColor,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        height: 50,
        onPressed: widget.onPressed,
        child: Text(
          widget.text,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

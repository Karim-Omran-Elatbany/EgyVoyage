import 'package:egyvoyage/Constants/constant.dart';
import 'package:flutter/material.dart';
class CustomButton extends StatefulWidget {
    CustomButton({super.key ,required this.text , this.onPressed});
  String text ;
  void Function()? onPressed ;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 10),
      child: MaterialButton(
        splashColor: kPrimaryColor,
        focusColor: kPrimaryColor,
        // hoverColor: kPrimaryColor,
        color: const Color(0xff8e3200),
        shape:OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        height: 50,
        onPressed:widget.onPressed,
        child:Text(widget.text, style: const TextStyle(color:Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
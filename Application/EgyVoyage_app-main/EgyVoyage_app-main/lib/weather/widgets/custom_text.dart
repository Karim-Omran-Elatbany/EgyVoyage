import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText(this.text,
      {super.key,
      this.color = Colors.white,
      this.fontWeight = FontWeight.w500,
      this.fontSize = 20,
      this.maxLines = 2});
  final Color color;
  final double fontSize;
  final String text;
  final FontWeight fontWeight;
  final int maxLines;
  pacifico() {
    return Text(
      text,
      style: GoogleFonts.pacifico(
          fontSize: fontSize, color: color, fontWeight: fontWeight),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
          fontSize: fontSize, color: color, fontWeight: fontWeight),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
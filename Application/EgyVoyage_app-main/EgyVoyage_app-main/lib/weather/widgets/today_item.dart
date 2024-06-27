import 'package:flutter/material.dart';
import 'package:egyvoyage/weather/widgets/custom_text.dart';

class TodayItem extends StatelessWidget {
  const TodayItem({
    super.key,
    required this.degree,
    required this.time,
    required this.imagePath,
  });
  final double degree;
  final String time;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        margin: const EdgeInsets.all(15),
        color: const Color(0xff331c71).withOpacity(0.6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              time,
              fontSize: 12,
            ),
            Image.asset(
              imagePath,
              height: 50,
            ),
            CustomText(
              '$degree°',
              fontSize: 12,
            )
          ],
        ),
      ),
    );
  }
}

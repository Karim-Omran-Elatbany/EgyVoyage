import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:egyvoyage/weather/models/weather_model.dart';
import 'package:egyvoyage/weather/widgets/custom_text.dart';
import 'package:egyvoyage/weather/widgets/weather_info_body.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.day,
  });
  final Day day;
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(day.date);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 20,
      margin: const EdgeInsets.all(15),
      color: const Color(0xff331c71).withOpacity(0.6),
      child: SizedBox(
        height: 65,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomText(
                    DateFormat.EEEE().format(dateTime),
                    fontSize: 14,
                  ),
                  
                ],
              ),
              Image.asset(
                getWeatherImagePath(condition: day.condition),
                height: 50,
              ),
              CustomText(
                '${day.maxTemp.toInt()}°',
                fontSize: 14,
              ),
              CustomText(
                '${day.minTemp.toInt()}°',
                fontSize: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

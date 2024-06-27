import 'package:flutter/material.dart';
import 'package:egyvoyage/weather/constants/assets.dart';
import 'package:egyvoyage/weather/models/weather_model.dart';
import 'package:egyvoyage/weather/widgets/custom_column.dart';
import 'package:egyvoyage/weather/widgets/custom_text.dart';
import 'package:egyvoyage/weather/widgets/weather_info_body.dart';

class Mycontainter extends StatelessWidget {
   const Mycontainter({super.key, required this.weatherModel});
  final WeatherModel weatherModel;
  @override
  Widget build(BuildContext context) { 
     List<Day> tomorrow = weatherModel.days;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 300,
      width: 350,
      decoration: BoxDecoration(
          color: const Color(0xff331c71),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                getWeatherImagePath(condition: tomorrow[1].condition),
                height: 120,
              ),
              Column(
                children: [
                  const CustomText(
                    'Tomorrrow',
                  // fontSize: 20,
                  ),
                   CustomText(tomorrow[1].condition,).pacifico()
                ],
              )
            ],
          ),
           Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: CustomText(
              '${tomorrow[1].avgTemp.toInt()}°',
              fontSize: 30,
            ),
          ),
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomColumn(
                  imagePath: Assets.assetsImagesProtection,
                  text: 'Precipitation',
                  value: '${tomorrow[1].preciptation.toInt()} %',
                ),
                CustomColumn(
                  imagePath: Assets.assetsImagesHumidity,
                  text: 'Humidity',
                  value: '${tomorrow[1].humdity.toInt()} %',
                ),
                CustomColumn(
                  imagePath: Assets.assetsImagesAir,
                  text: 'Wind speed',
                  value: '${tomorrow[1].windSpeed.toInt()} %',
                ),
              ])
        ],
      ),
    );
  }
}

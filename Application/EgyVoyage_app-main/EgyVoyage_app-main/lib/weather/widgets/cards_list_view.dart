import 'package:flutter/material.dart';
import 'package:egyvoyage/weather/models/weather_model.dart';
import 'package:egyvoyage/weather/widgets/custom_card.dart';

class CardsListView extends StatelessWidget {
  const CardsListView({super.key, required this.weatherModel});
  final WeatherModel weatherModel;
  @override
  Widget build(BuildContext context) {
    List<Day> days = weatherModel.days;
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: days.length-2,
        itemBuilder: (BuildContext context, int index) {
          int startIndex = index + 2;
          return CustomCard(day: days[startIndex]);
        },
      ),
    );
  }
}

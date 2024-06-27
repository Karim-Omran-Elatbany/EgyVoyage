import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:egyvoyage/weather/cubits/get_weather_states.dart';
import 'package:egyvoyage/weather/cubits/get_wether_cubit.dart';
import 'package:egyvoyage/weather/models/weather_model.dart';
import 'package:egyvoyage/weather/widgets/custom_column.dart';
import 'package:egyvoyage/weather/widgets/custom_text.dart';
import 'package:egyvoyage/weather/widgets/items_list_view.dart';

import '../constants/assets.dart';
class WeatherInfoBody extends StatelessWidget {
  const WeatherInfoBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WeatherModel weatherModel =
        BlocProvider.of<GetWeatherCubit>(context).weatherModel!;
    DateTime time = DateTime.parse(weatherModel.localtime);
    return  Align(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter,
                colors: [
              const Color(0xFF5842A9),
              const Color(0xff5842A9).withOpacity(.6)
            ])),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  '${weatherModel.avgTemp.toInt()}°',
                  fontWeight: FontWeight.w500,
                  fontSize: 80,
                ),
                CustomText(
                  weatherModel.cityName,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ],
            ),
            Image.asset(
              getWeatherImagePath(condition: weatherModel.condtion),
              height: 170,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomText(
                weatherModel.condtion,
                fontSize: 25,
              ).pacifico(),
            ),
            CustomText(
              DateFormat.MMMMEEEEd().format(time),
              fontSize: 14,
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xff331c71),
                    borderRadius: BorderRadius.circular(16)),
                height: 120,
                width: 360,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomColumn(
                        imagePath: Assets.assetsImagesProtection,
                        text: 'Precipitation ',
                        value: '${weatherModel.preciptation} %',
                      ),
                      CustomColumn(
                        imagePath: Assets.assetsImagesHumidity,
                        text: 'Humidity',
                        value: '${weatherModel.humdity} %',
                      ),
                      CustomColumn(
                        imagePath: Assets.assetsImagesAir,
                        text: 'Wind speed',
                        value: '${weatherModel.windSpeed} %',
                      ),
                    ])),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    'Today',
                    fontSize: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, 'DetailsView');
                    },
                    child: SizedBox(
                      height: 40,
                      width: 150,
                      child: Card(
                        elevation: 10,
                        color: const Color(0xff331c71).withOpacity(0.2),
                        child: const Center(
                          child: CustomText(
                            '7-day Forcast',
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            BlocBuilder<GetWeatherCubit, WeatherStates>(
              builder: (context, state) {
                return const ItemsListView();
              },
            ),
          ],
        ),
      ),
    );
  }
}

String getWeatherImagePath({required String? condition}) {
  switch (condition) {
    case 'Sunny':
      return Assets.assetsImages6;
    case 'Partly cloudy':
      return Assets.assetsImages7;
    case 'Cloudy':
    case 'Overcast':
    case 'Mist':
    case 'Fog':
    case 'Freezing fog':
      return Assets.assetsImages8;
    case 'Patchy rain possible':
    case 'Patchy snow possible':
    case 'Patchy sleet possible':
    case 'Patchy freezing drizzle possible':
    case 'Blowing snow':
    case 'Blizzard':
    case 'Light drizzle':
    case 'Freezing drizzle':
    case 'Heavy freezing drizzle':
    case 'Patchy light drizzle':
      return Assets.assetsImages2;
    case 'Thundery outbreaks possible':
    case 'Patchy light rain':
    case 'Light rain':
    case 'Moderate rain at times':
    case 'Moderate rain':
    case 'Heavy rain at times':
    case 'Heavy rain':
    case 'Light freezing rain':
    case 'Moderate or heavy freezing rain':
      return Assets.assetsImages3;
    case 'Light sleet':
    case 'Moderate or heavy sleet':
      return Assets.assetsImages5;
    case 'Patchy light snow':
    case 'Light snow':
    case 'Patchy moderate snow':
    case 'Moderate snow':
    case 'Patchy heavy snow':
    case 'Heavy snow':
      return Assets.assetsImages4;
    case 'Ice pellets':
      return Assets.assetsImages4;
    case 'Light rain shower':
    case 'Moderate or heavy rain shower':
    case 'Torrential rain shower':
      return Assets.assetsImages3;
    case 'Light snow showers':
    case 'Moderate or heavy snow showers':
      return Assets.assetsImages4;
    case 'Light showers of ice pellets':
    case 'Moderate or heavy showers of ice pellets':
      return Assets.assetsImages4;
    case 'Patchy light rain with thunder':
    case 'Moderate or heavy rain with thunder':
    case 'Patchy light snow with thunder':
    case 'Moderate or heavy snow with thunder':
      return Assets.assetsImages1;
    default:
      return Assets.assetsImages12;
  }
}

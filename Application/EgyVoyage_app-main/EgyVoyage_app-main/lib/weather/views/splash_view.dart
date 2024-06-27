import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:egyvoyage/weather/constants/assets.dart';
import 'package:egyvoyage/weather/constants/colors.dart';
import 'package:egyvoyage/weather/cubits/get_wether_cubit.dart';
import 'package:egyvoyage/weather/widgets/custom_text.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    var fun = BlocProvider.of<GetWeatherCubit>(context);
    Timer(const Duration(seconds: 3), () async {
      Navigator.pushReplacementNamed(context, 'HomeView');
      Position position = await determinePosition();
      double longitude = position.longitude;
      double latitude = position.latitude;
      String cityName = '$latitude,$longitude';
      print('$latitude,$longitude');
      fun.getWeather(cityName: cityName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(Assets.assetsImagesAnimation),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: CustomText(
                'Weather App',
                color: MyColors.mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            CustomText(
              'all rights reserved © 2023',
              color: MyColors.mainColor.withOpacity(0.7),
              fontSize: 12,
            )
          ],
        ),
      ),
    );
  }
}

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

// Future<String> fetchLocation() async {
//   Position position = await determinePosition();
//   double longitude = position.longitude;
//   double latitude = position.latitude;
//   String city = '$latitude,$longitude';
//   return city;
// }

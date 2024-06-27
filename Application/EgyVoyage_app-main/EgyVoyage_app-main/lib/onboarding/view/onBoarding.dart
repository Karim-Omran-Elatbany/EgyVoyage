import 'package:egyvoyage/Authentication/Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:lottie/lottie.dart';

import 'widget/card-plant.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({Key? key}) : super(key: key);

  final List<CardPlanetData> data = [
    CardPlanetData(
      title: "Home Page",
      subtitle: "Through this page, we display the most important and newest tourist places in Egypt.",
      image: const AssetImage("assets/onboarding/image.png"),
      backgroundColor:  Colors.white,
      titleColor: Colors.pink,
      subtitleColor: Colors.black87,
      background: LottieBuilder.asset("assets/onboarding/animation/bg-1.json"),
    ),
    CardPlanetData(
      title: "Book Hotels",
      subtitle: "Through this page, we provide you with a happy stay by displaying the best hotels and luxury rooms.",
      image: const AssetImage("assets/onboarding/hotel.png"),
      backgroundColor:const Color(0xffecd0e0),
      titleColor: Colors.purple,
      subtitleColor:  Colors.black87,
      background: LottieBuilder.asset("assets/onboarding/animation/bg-2.json"),
    ),
    CardPlanetData(
      title: "Model",
      subtitle: "Through this page, we have devoted artificial intelligence to help you discover Egyptian monuments and how to reach the.",
      image: const AssetImage("assets/onboarding/model.png"),
      backgroundColor: const Color(0xff14213d),
      titleColor: Colors.yellow,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/onboarding/animation/bg-3.json"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        itemBuilder: (int index) {
          return CardPlanet(data: data[index]);
        },
        onFinish: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
          );
        },
      ),
    );
  }
}

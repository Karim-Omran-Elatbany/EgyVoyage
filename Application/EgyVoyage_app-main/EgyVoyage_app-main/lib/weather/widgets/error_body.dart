import 'package:flutter/material.dart';
import 'package:egyvoyage/weather/constants/assets.dart';
import 'package:egyvoyage/weather/widgets/custom_text.dart';

class ErrorBody extends StatelessWidget {
  const ErrorBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            Assets.assetsImagesError,
          ),
          const CustomText(
            'Oops , No Matching location ',
            fontSize: 18,
            color: Colors.black,
          ),
          const CustomText(
            ' try again !',
            color: Colors.black,
          )
        ],
      ),
    );
  }
}

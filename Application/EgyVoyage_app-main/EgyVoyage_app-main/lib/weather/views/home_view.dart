// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:egyvoyage/weather/constants/colors.dart';
import 'package:egyvoyage/weather/cubits/get_weather_states.dart';
import 'package:egyvoyage/weather/cubits/get_wether_cubit.dart';
import 'package:egyvoyage/weather/widgets/custom_text.dart';
import 'package:egyvoyage/weather/widgets/error_body.dart';
import 'package:egyvoyage/weather/widgets/no_weather_body.dart';

import '../../Home_view/Screens/home_screen.dart';
import '../widgets/weather_info_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: (){
              Navigator.of(context).pushNamed(HomePage.id);
            },
          ),
          title: const CustomText(
            'Weather',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          centerTitle: true,
          backgroundColor: MyColors.mainColor,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'SearchView');
                },
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0xff331c71),
                        borderRadius: BorderRadius.circular(12)),
                    height: 40,
                    width: 40,
                    child: const FaIcon(
                      FontAwesomeIcons.searchengin,
                      size: 25,
                    )),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<GetWeatherCubit, WeatherStates>(
            builder: (context, state) {
              if (state is WeatherLoadedState) {
                return WeatherInfoBody();
              } else(state is FaliureState);
                return ErrorBody();
              // else
              //   return const NoWeatherBody();
            },
          ),
        ));
  }
}

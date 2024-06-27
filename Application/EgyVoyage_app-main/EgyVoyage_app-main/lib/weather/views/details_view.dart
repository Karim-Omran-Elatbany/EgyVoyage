import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:egyvoyage/weather/constants/colors.dart';
import 'package:egyvoyage/weather/cubits/get_wether_cubit.dart';
import 'package:egyvoyage/weather/models/weather_model.dart';
import 'package:egyvoyage/weather/widgets/cards_list_view.dart';
import 'package:egyvoyage/weather/widgets/custom_text.dart';
import 'package:egyvoyage/weather/widgets/my_container.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    WeatherModel weatherModel =
        BlocProvider.of<GetWeatherCubit>(context).weatherModel!;
    return Scaffold(
        appBar: AppBar(
          title: const CustomText(
            'Forcasts',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          backgroundColor:  MyColors.mainColor,
          elevation: 0,
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter,
                  colors: [
                 MyColors.mainColor,
                 MyColors.mainColor.withOpacity(.6)
              ])),
          child: Column(
            children: [
              Mycontainter(weatherModel: weatherModel),
              CardsListView(weatherModel: weatherModel)
            ],
          ),
        ));
  }
}

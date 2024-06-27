import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:egyvoyage/weather/cubits/get_wether_cubit.dart';
import 'package:egyvoyage/weather/models/weather_model.dart';
import 'package:egyvoyage/weather/widgets/today_item.dart';
import 'package:egyvoyage/weather/widgets/weather_info_body.dart';

class ItemsListView extends StatelessWidget {
  const ItemsListView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    List<Hour> hours =
        BlocProvider.of<GetWeatherCubit>(context).weatherModel!.hours;
    var weatherModel = BlocProvider.of<GetWeatherCubit>(context).weatherModel;

    return SizedBox(
      height: 130,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: hours.length,
        itemBuilder: (BuildContext context, int index) {
          return TodayItem(
            degree: hours[index].tempC,
            imagePath: getWeatherImagePath(condition: weatherModel!.condtion),
            time: DateFormat.j().format(hours[index].time),
          );
        },
      ),
    );
  }
}

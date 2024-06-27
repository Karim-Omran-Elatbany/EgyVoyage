import 'package:egyvoyage/weather/services/weather_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:egyvoyage/weather/cubits/get_weather_states.dart';
import 'package:egyvoyage/weather/models/weather_model.dart';

class GetWeatherCubit extends Cubit<WeatherStates> {
  GetWeatherCubit() : super(WeatherIntialState());
  late WeatherModel weatherModel;
  getWeather({required String cityName}) async {
    try {
      weatherModel = await WeatherServices().getWeather(cityName: cityName);
      emit(WeatherLoadedState());
    } catch (e) {
      emit(FaliureState());
    }
  }
}

import 'package:dio/dio.dart';
import 'package:egyvoyage/weather/models/weather_model.dart';

class WeatherServices {
  final Dio dio = Dio();
  String baseurl = 'https://api.weatherapi.com/v1/';
  String endpoint = 'forecast.json';
  String apiKey = 'f479254126934d61883135436242202';
  Future<WeatherModel> getWeather({required String cityName}) async {
    try {
      final Response response = await dio.get(baseurl + endpoint,
          queryParameters: {'key': apiKey, 'days': 7, 'q': cityName});
      dynamic json = response.data;
      return WeatherModel.fromJson(json);
    } on DioException catch (e) {
      final String errorMassage =
          e.response?.data['error']['message'] ?? 'oops! something went wrong ';
      //! -->sure 100% can't be null
      //? --> response is null don't access .data['error']['message']
      throw Exception(errorMassage);
    }
  }
}

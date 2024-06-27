class WeatherModel {
  final String cityName;
  final String localtime;
  final String condtion;
  final double avgTemp;
  final int humdity;
  final double windSpeed;
  final double preciptation;
  final List<Hour> hours;
  final List<Day> days;
  WeatherModel(
      {required this.days,
      required this.cityName,
      required this.localtime,
      required this.condtion,
      required this.avgTemp,
      required this.humdity,
      required this.windSpeed,
      required this.preciptation,
      required this.hours});
  factory WeatherModel.fromJson(dynamic json) {
    dynamic details = json['location']; //first map
    dynamic forecast = json['forecast']['forecastday'][0]['day'];
    // list<>
    List<dynamic> hourList = json['forecast']['forecastday'][0]['hour'];
    List<dynamic> jsonDays = json['forecast']['forecastday'];
    List<Day> days = List.generate(
        jsonDays.length, (index) => Day.fromJson(jsonDays[index]));
    List<Hour> hours = List.generate(
        hourList.length, (index) => Hour.fromJson(hourList[index]));
    dynamic current = json['current'];
    return WeatherModel(
      cityName: details['name'],
      localtime: current['last_updated'],
      condtion: forecast['condition']['text'],
      avgTemp: forecast['avgtemp_c'],
      humdity: current['humidity'],
      windSpeed: current['wind_kph'],
      preciptation: current['precip_in'],
      hours: hours,
      days: days,
    );
  }
}

class Day {
  final double maxTemp;
  final double minTemp;
  final double avgTemp;
  final double windSpeed;
  final double preciptation;
  final int humdity;
  final String condition;
  final String date;
  Day(
      {required this.date,
      required this.maxTemp,
      required this.minTemp,
      required this.avgTemp,
      required this.windSpeed,
      required this.preciptation,
      required this.humdity,
      required this.condition});
  factory Day.fromJson(dynamic json) {
    dynamic day = json['day'];
    return Day(
        date: json['date'],
        maxTemp: day['maxtemp_c'],
        minTemp: day['mintemp_c'],
        avgTemp: day['avgtemp_c'],
        windSpeed: day['maxwind_kph'],
        preciptation: day['totalprecip_mm'],
        humdity: day['avghumidity'],
        condition: day['condition']['text']);
  }
}

class Hour {
  final DateTime time;
  final double tempC;

  Hour({required this.time, required this.tempC});
  factory Hour.fromJson(dynamic json) {
    return Hour(time: DateTime.parse(json['time']), tempC: json['temp_c']);
  }
}

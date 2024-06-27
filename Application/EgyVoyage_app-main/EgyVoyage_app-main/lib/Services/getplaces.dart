import 'package:dio/dio.dart';
import 'package:egyvoyage/Services/models/placesmodel.dart';

class Placesservices {
  final Dio dio;

  Placesservices(this.dio);

  Future<List<PlaceseModel>> getPlaces() async {
    try {
      Response response = await dio.get("http://egyvoyage2.somee.com/api/Place");
      List places = response.data;

      List<PlaceseModel> placeslist = [];
      for (var place in places) {
        print('adult_price type: ${place['adult_price'].runtimeType}');
        print('child_price type: ${place['child_price'].runtimeType}');
        print('tourist_price type: ${place['tourist_price'].runtimeType}');

        PlaceseModel placeseModel = PlaceseModel(
          id: place['id'],
          cordinate: place['cordinate'],
          city: place['city'],
          url_location: place['url_location'],
          rating: (place['rating'] as num?)?.toDouble(),
          image: place['image'],
          name: place['name'],
          description: place['description'],
          start: place['start'],
          end: place['end'],
          adultprice: place['adult_price'] is int ? place['adult_price'] : (place['adult_price'] as num).toInt(),
          childprice: place['child_price'] is int ? place['child_price'] : (place['child_price'] as num).toInt(),
          tourist: place['tourist_price'] is int ? place['tourist_price'] : (place['tourist_price'] as num).toInt(),
        );

        placeslist.add(placeseModel);
      }
      print(placeslist);
      return placeslist;
    } catch (e) {
      print("///////////////////////");
      print(e);
      return [];
    }
  }
}
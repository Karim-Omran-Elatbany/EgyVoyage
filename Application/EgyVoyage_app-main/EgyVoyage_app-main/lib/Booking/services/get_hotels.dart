import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:egyvoyage/Booking/data_models/hotel_model.dart';
import 'package:egyvoyage/Booking/services/get_location.dart';

Future<void> fetchDataFromApi(Map<String, dynamic> args) async {
  await getCurrentLocation( args['currentLat'], args['currentLong']);
  print(args);
  try {


    // Make the HTTP POST request using dio
    Response response = await Dio().post(
      'http://egyvoyage.somee2.com/api/Reservation/search',
      data: args,
    );

    // Parse the JSON response into HotelModel objects
    List<dynamic> responseData = response.data;
    List<HotelModel> hotels =
    responseData.map((data) => HotelModel.fromJson(data)).toList();

    print('got response');
    log(hotels[0].rooms[0].image);
    // Update the listHotel with the fetched data

  } catch (error) {
    print('Error fetching data: $error');
    // Set isLoading to false if there's an error fetching data

  }
}

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:egyvoyage/Booking/data_models/hotel_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Constant/globals.dart';
import '../widgets/app_bar_container.dart';
import '../widgets/item_hotel_widget.dart';

class HotelsScreen extends StatefulWidget {
  const HotelsScreen({super.key, required this.args});
  static String id = 'HotelsScreen';
  final Map<String, dynamic> args;
  @override
  State<HotelsScreen> createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {
  List<HotelModel> listHotel = [];
  bool isLoading = false; // Track whether data is being fetched or not

  // Method to sort hotels based on price
  void sortHotelsByPrice() {
    listHotel.sort((a, b) => a.price.compareTo(b.price));
    setState(() {});
  }

  // Method to sort hotels based on rating
  void sortHotelsByRating() {
    listHotel.sort((a, b) => b.rating.compareTo(a.rating));
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    fetchDataFromApi(widget.args);
  }



  Future<void> fetchDataFromApi(Map<String, dynamic> args) async {
    print(args);
    try {
      // Set isLoading to true before making the request
      setState(() {
        isLoading = true;
      });

      // Make the HTTP POST request using dio
      Response response = await Dio().post(
        'http://egyvoyage2.somee.com/api/Reservation/search',
        data: args,
      );

      // Parse the JSON response into HotelModel objects
      List<dynamic> responseData = response.data;
      List<HotelModel> hotels =
          responseData.map((data) => HotelModel.fromJson(data)).toList();

      print('got response');
      log(hotels[0].rooms[0].image);
      // Update the listHotel with the fetched data
      setState(() {
        listHotel.addAll(hotels);
        // Set isLoading to false after data is fetched
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching data: $error');
      // Set isLoading to false if there's an error fetching data
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
      implementLeading: true ,
      titleString: 'Hotels',
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: sortHotelsByPrice,
                    child:  Text('Sort by Price',
                        style:Theme.of(context).textTheme.bodyText1
                    ),
                  ),
                  ElevatedButton(
                    onPressed: sortHotelsByRating,
                    child:  Text('Sort by Rating',
                     style:Theme.of(context).textTheme.bodyText1
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: listHotel
                          .map((e) => ItemHotelWidget(
                        hotelModel: e,
                        currentLat: globalCurrentLat,
                        currentLong: globalCurrentLong,
                        nights: calculateNumberOfNights(widget.args['start'],widget.args['end']),
                        dates: [widget.args['start'],widget.args['end']],

                              ))
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  int calculateNumberOfNights(String startDate, String endDate) {
    // Define the date format
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    // Parse the date strings into DateTime objects
    final DateTime start = formatter.parse(startDate);
    final DateTime end = formatter.parse(endDate);

    // Calculate the difference in days
    final int numberOfNights = end.difference(start).inDays;

    return numberOfNights;
  }
}

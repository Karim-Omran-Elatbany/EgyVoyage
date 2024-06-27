import 'package:dio/dio.dart';
import 'package:egyvoyage/Booking/Screens/select_room_screen.dart';
import 'package:egyvoyage/Booking/data_models/review_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../CustomsWidget/custom_button.dart';
import '../../Home_view/widgets/maps.dart';
import '../Constant/constant.dart';
import '../data_models/hotel_model.dart';
import '../helpers/image_helper.dart';
import '../widgets/review_widget.dart';

class HotelDetailScreen extends StatefulWidget {
  const HotelDetailScreen(
      {super.key, required this.hotelModel, required this.nights});

  static const String id = 'HotelDetail';
  final HotelModel hotelModel;
  final int nights;
  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  late Future<List<ReviewModel>> reviews;
  Future<List<double>> getCoordinates() async {
    List<String> parts = widget.hotelModel.coordinates!.split(",");
    print('hotel coordinates:${widget.hotelModel.coordinates}');
    double latitude = double.parse(parts[0]);
    double longitude = double.parse(parts[1]);
    return [latitude, longitude];
  }

  Future<List<ReviewModel>> fetchReviews(int hotelId) async {
    final String apiUrl =
        'http://egyvoyage2.somee.com/api/FeedBack?hotel_id=$hotelId';

    Dio dio = Dio();

    try {
      final response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => ReviewModel.fromJson(json)).toList();
      } else {
        print('Failed to fetch reviews: ${response.statusCode}');
        return [];
      }
    } on DioError catch (e) {
      print('Error fetching reviews: ${e.message}');
      if (e.response != null) {
        print('Error details: ${e.response?.data}');
      }
      return [];
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reviews=fetchReviews(widget.hotelModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ImageHelper.loadFromNetwork(widget.hotelModel.image,
                fit: BoxFit.fill),
          ),
          Positioned(
              top: kMediumPadding * 2,
              left: kMediumPadding,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(kItemPadding),
                  decoration:  BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.circular(kItemPadding)),
                      color:Theme.of(context).colorScheme.surface,
                  ),
                  child: const Icon(
                    FontAwesomeIcons.arrowLeft,
                    size: 18,
                  ),
                ),
              )),
          DraggableScrollableSheet(
              initialChildSize: 0.3,
              maxChildSize: 0.8,
              minChildSize: 0.3,
              builder: (context, scrollController) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kMediumPadding),
                  decoration:  BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(kDefaultPadding * 2),
                          topRight: Radius.circular(kDefaultPadding * 2))),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: kDefaultPadding),
                        child: Container(
                          height: 5,
                          width: 60,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(kItemPadding)),
                              color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      Expanded(
                          child: ListView(
                        controller: scrollController,
                        children: [
                          Text(
                            widget.hotelModel.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const Spacer(),
                          Text(
                            '\$${widget.hotelModel.price * widget.nights}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text('for ${widget.nights} nights'),
                          const SizedBox(
                            height: kDefaultPadding,
                          ),
                          Row(
                            children: [
                              ImageHelper.loadFromAsset(
                                  'assets/images/location.png',
                                  height: 20,
                                  width: 20),
                              const SizedBox(
                                width: kMinPadding,
                              ),
                              Text(
                                widget.hotelModel.location,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: kDefaultPadding,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 27,
                              ),
                              const SizedBox(
                                width: kMinPadding,
                              ),
                              Text(
                                '${widget.hotelModel.rating} / 10.0',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              // const Spacer(),
                              // TextButton(
                              //     onPressed: (){
                              //
                              //     },
                              //     child: const Text(
                              //       'view reviews',
                              //       style: TextStyle(fontSize: 18),
                              //     ))
                            ],
                          ),
                          const SizedBox(
                            height: kDefaultPadding,
                          ),
                          const Text(
                            'Information',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(
                            height: kDefaultPadding,
                          ),
                          Text(
                            widget.hotelModel.description,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: kDefaultPadding,
                          ),
                          const SizedBox(
                            height: kDefaultPadding,
                          ),
                          const Text(
                            'Location',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(
                            height: kDefaultPadding,
                          ),
                          FutureBuilder<List<double>>(
                              future: getCoordinates(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.length != 2) {
                                  return const Center(
                                      child: Text('Invalid data'));
                                }

                                double latitude = snapshot.data![0];
                                double longitude = snapshot.data![1];

                                return PlacesMaps(latitude, longitude);
                              }),

                          const SizedBox(
                            height: kDefaultPadding,
                          ),
                          const Text(
                            'Reviews',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          FutureBuilder<List<ReviewModel>>(
                            future: reviews,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return const Center(
                                    child: Text('No reviews found.'));
                              } else {
                                return Column(
                                  children: snapshot.data!
                                      .map((review) =>
                                          ReviewWidget(review: review))
                                      .toList(),
                                );
                              }
                            },
                          ),
                        ],
                      )),
                      CustomButton(
                        text: 'Select Room',
                        onPressed: () {
                          Navigator.of(context).pushNamed(SelectRoomScreen.id,
                              arguments: {
                                'hotelModel': widget.hotelModel,
                                'nights': widget.nights
                              });
                        },
                      )
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}

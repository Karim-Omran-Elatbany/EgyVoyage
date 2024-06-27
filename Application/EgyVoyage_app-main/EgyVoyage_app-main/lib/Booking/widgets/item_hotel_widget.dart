
import 'package:flutter/material.dart';

import '../../CustomsWidget/custom_button.dart';
import '../Constant/constant.dart';
import '../Constant/globals.dart';
import '../Screens/hotel_detail_screen.dart';
import '../data_models/hotel_model.dart';
import '../helpers/image_helper.dart';
import 'dashline_widget.dart';

class ItemHotelWidget extends StatelessWidget {
  const ItemHotelWidget(
      {super.key,
      required this.hotelModel,
      required this.currentLat,
      required this.currentLong,
      required this.nights,
        required this.dates
      });
  final HotelModel hotelModel;
  final double currentLat;
  final double currentLong;
  final int nights;
  final List<String> dates;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding),
        color: Theme.of(context).colorScheme.surface ,
      ),
      margin: const EdgeInsets.only(bottom: kMediumPadding),
      child: Column(
        children: [
          Container(
              width: double.infinity,
              margin: const EdgeInsets.only(right: kDefaultPadding),
              child: ImageHelper.loadFromNetwork(hotelModel.image,
                  radius: const BorderRadius.only(
                    topLeft: Radius.circular(kDefaultPadding),
                    bottomRight: Radius.circular(kDefaultPadding),
                  ),
                  height: 250)),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding, vertical: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotelModel.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                Row(
                  children: [
                    Text(hotelModel.location),
                    Expanded(
                      child: Text(
                        ' - ${calculateDistanceFromCoordinates(hotelModel.coordinates, globalCurrentLat, globalCurrentLong).toStringAsFixed(2)}km',
                        style: const TextStyle(color: Colors.grey),
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                Row(
                  children: [
                    const Icon(Icons.star,color: Colors.yellow,size: 25,),
                    const SizedBox(
                      width: kMinPadding,
                    ),
                    Text(hotelModel.rating.toString()),
                  ],
                ),
                const DashLineWidget(color: Colors.orange),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' US\$ ${hotelModel.price*nights}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: kMinPadding,
                          ),
                          Text('for $nights nights')
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: CustomButton(
                        text: 'Show Details',
                        onPressed: () {
                          globalHotelModel=hotelModel;
                          Navigator.of(context).pushNamed(HotelDetailScreen.id,
                              arguments: {
                                'hotelModel':hotelModel,
                                'nights':nights,
                                'dates': dates
                              });
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}//Marina El Alamein

import 'package:egyvoyage/Home_view/widgets/places.dart';
import 'package:egyvoyage/Services/models/placesmodel.dart';
import 'package:flutter/material.dart';

import '../../Booking/Constant/constant.dart';
import '../Screens/post_screen.dart';

class PlacesListView extends StatelessWidget {
  PlacesListView({required this.places});

  List<PlaceseModel> places = [];
  List<PlaceseModel> getPlacesSortedByRating() {
    List<PlaceseModel> sortedPlaces = List.from(places);
    sortedPlaces.sort((a, b) => b.rating!.compareTo(a.rating!));
    return sortedPlaces;
  }

  @override
  Widget build(BuildContext context) {
    List<PlaceseModel>orderedplaces=getPlacesSortedByRating();
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orderedplaces.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.all(15),
            child: Places(placeseModel: orderedplaces[index]));
      },
    );
  }
}

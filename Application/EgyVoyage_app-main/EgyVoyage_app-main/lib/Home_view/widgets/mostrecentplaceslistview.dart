import 'package:egyvoyage/Home_view/widgets/mostrecent.dart';
import 'package:flutter/material.dart';

import '../../Services/models/placesmodel.dart';

class MostRecentListview extends StatelessWidget {
   MostRecentListview({required this.places,super.key});
  List<PlaceseModel> places = [];
   List<PlaceseModel> getLatestTenPlaces() {
     // Return the last 10 items or fewer if there are less than 10 items
     final count = places.length;
     return count > 10 ? places.sublist(count - 10, count) : places;
   }


  @override
  Widget build(BuildContext context) {
     List<PlaceseModel>tenplaces=getLatestTenPlaces();
    return ListView.builder(
        itemCount: tenplaces.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Mostrecent(placeseModel: tenplaces[index]);
        });
  }
}

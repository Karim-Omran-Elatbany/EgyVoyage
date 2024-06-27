import 'package:egyvoyage/Home_view/widgets/placeslistview.dart';
import 'package:flutter/material.dart';

import '../../Booking/Constant/constant.dart';
import '../../Services/models/placesmodel.dart';

class SearchResult extends StatelessWidget {
  SearchResult({required this.placesfsearch});

  List<PlaceseModel> placesfsearch = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            //padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: kPrimaryColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 6,
                  )
                ],
                borderRadius: BorderRadius.circular(15)),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 25,
                )),
          ),
        ),
        title: Row(
          children: [
            SizedBox(
              width: 30,
            ),
            Icon(
              Icons.location_on,
              color: kPrimaryColor,
            ),
            Text(
              '${placesfsearch[0].city}, Egypt',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PlacesListView(places: placesfsearch),
          ],
        ),
      ),
    );
  }
}

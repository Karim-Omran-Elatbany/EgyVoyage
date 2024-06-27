import 'package:egyvoyage/Home_view/Screens/post_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Booking/Constant/constant.dart';
import '../../Services/models/placesmodel.dart';
import '../provider/favoriteprovider.dart';
import '../widgets/places.dart';

class Showfavoritelist extends StatelessWidget {
  const Showfavoritelist({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the FavoriteProvider to get the list of favorite places
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    // Retrieve the list of favorite places
    final List<PlaceseModel> favoritePlaces = favoriteProvider.favoritePlaces;

    return Scaffold(
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
        title: Padding(
          padding: const EdgeInsets.only(left: 60),
          child: Text(
            'Favorits',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: kPrimaryColor),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: favoritePlaces.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Places(placeseModel: favoritePlaces[index]));
              },
            )
          ],
        ),
      ),
    );
  }
}

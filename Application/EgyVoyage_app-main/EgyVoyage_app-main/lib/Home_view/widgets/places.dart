import 'package:egyvoyage/Services/models/placesmodel.dart';
import 'package:flutter/material.dart';
import '../../Authentication/data/shared-preferences-service.dart';
import '../../Booking/Constant/constant.dart';
import '../Screens/post_screen.dart';
 // Import SharedPreferencesService

class Places extends StatelessWidget {
  Places({required this.placeseModel, super.key});

  final PlaceseModel placeseModel;
  Map<String, String> userData = {
    'fName': '',
    'lName': '',
    'phone': '',
    'nationality': '',
    'ssn': '',
    'birthdate': '',
    'email': '',
    'password': '',
  };

  Future<void> _loadUserData() async {
    SharedPreferencesService prefsService = SharedPreferencesService();
    Map<String, String> data = await prefsService.loadUserData();
    userData = data;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            await _loadUserData();
            String? userEmail = userData['email'];
            if (userEmail != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostScreen(
                    placeseModel: placeseModel,
                    userEmail: userEmail, // Pass userEmail to PostScreen
                  ),
                ),
              );
            } else {
              // Handle case where user email is not found
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('User email not found!')),
              );
            }
          },
          child: Container(
            height: 200,
            decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage(placeseModel.image ?? ''),
                    //assets/photo/Home/post_screen_1.jpg
                    fit: BoxFit.fill,
                    opacity: 0.8)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                placeseModel.name ?? '',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.more_vert,
                size: 30,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Icon(
              Icons.star,
              color: Colors.amber,
              size: 20,
            ),
            Text(
              "${placeseModel.rating ?? 0}",
              style: TextStyle(fontWeight: FontWeight.w500),
            )
          ],
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../Authentication/data/shared-preferences-service.dart';
import '../../Services/models/placesmodel.dart';
import '../Screens/post_screen.dart';
 // Import SharedPreferencesService

class Mostrecent extends StatelessWidget {
  Mostrecent({required this.placeseModel, super.key});

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
    return InkWell(
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
        width: 160,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage(placeseModel.image ?? ""),
            fit: BoxFit.cover,
            opacity: 0.7,
          ),
        ),
        child: Column(
          children: [
            const Spacer(),
            Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                placeseModel.name ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:egyvoyage/Services/models/placesmodel.dart';
import 'package:flutter/material.dart';
import '../widgets/post_app_bar.dart';
import '../widgets/post_bottom_bar.dart';

class PostScreen extends StatelessWidget {
  final PlaceseModel placeseModel;
  final String userEmail; // Add userEmail parameter

  static const String id = 'PostScreen';

  PostScreen({required this.placeseModel, required this.userEmail}); // Update constructor

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(placeseModel.image ?? ''),
          fit: BoxFit.cover,
          opacity: 0.7,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: PostAppBar(
            placesModel: placeseModel,
            userEmail: userEmail, // Pass userEmail to PostAppBar
          ),
        ),
        bottomNavigationBar: PostBottomBar(placeseModel),
      ),
    );
  }
}

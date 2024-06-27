import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:egyvoyage/Services/models/placesmodel.dart';
import '../../Booking/Constant/constant.dart';
import '../provider/favoriteprovider.dart'; // Import the FavoriteProvider
 // Import SharedPreferencesService

class PostAppBar extends StatefulWidget {
  final PlaceseModel placesModel;
  final String userEmail; // Add userEmail parameter

  const PostAppBar({
    Key? key,
    required this.placesModel,
    required this.userEmail, // Initialize userEmail
  }) : super(key: key);

  @override
  State<PostAppBar> createState() => _PostAppBarState();
}

class _PostAppBarState extends State<PostAppBar> {
  late FavoriteProvider favoriteProvider; // Initialize FavoriteProvider

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Access the FavoriteProvider
    favoriteProvider = FavoriteProvider.of(context, listen: false);
    // Load user favorites when dependencies change
    favoriteProvider.loadFavorites(widget.userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 6,
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                // Toggle favorite status when tapped
                favoriteProvider.toggleFavorite(widget.placesModel, widget.userEmail);
              });
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Consumer<FavoriteProvider>(
                builder: (context, provider, child) {
                  // Check if the current place is in favorite places
                  final isFavorite = provider.isFavorite(widget.placesModel);
                  return Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_outline,
                    size: 28,
                    color: Colors.white,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

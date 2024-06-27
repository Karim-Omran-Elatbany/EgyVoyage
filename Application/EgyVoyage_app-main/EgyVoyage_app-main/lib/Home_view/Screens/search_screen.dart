import 'package:flutter/material.dart';
import '../../Services/models/placesmodel.dart';
import '../widgets/searchresultview.dart';

class SearchPage extends SearchDelegate {
  SearchPage(this.citiesList, this.names, this.filterednames);

  List<PlaceseModel> names = [];
  List<PlaceseModel> filterednames = [];
  List<PlaceseModel> citiesList = [];
  List<PlaceseModel> uniqueCities = [];

  List<PlaceseModel> getUniquePlaces(List<PlaceseModel> places) {
    Set<String> uniqueCityNames = {};
    List<PlaceseModel> uniquePlaces = [];

    for (var place in places) {
      if (!uniqueCityNames.contains(place.city)) {
        uniqueCityNames.add(place.city!);
        uniquePlaces.add(place);
      }
    }
    return uniquePlaces;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context); // Reset suggestions when query is cleared
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<PlaceseModel> searchResults = names
        .where((place) =>
        place.city!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index].city!),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SearchResult(placesfsearch: searchResults),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    uniqueCities = getUniquePlaces(names);

    Set<String> suggestionSet = {};
    List<PlaceseModel> suggestions = [];

    if (query.isEmpty) {
      suggestions = uniqueCities;
    } else {
      suggestions = names.where((place) {
        if (place.city!
            .toLowerCase()
            .contains(query.toLowerCase()) && suggestionSet.add(place.city!)) {
          return true;
        }
        return false;
      }).toList();
    }

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index].city!),
          onTap: () {
            List<PlaceseModel> placesInCity = names
                .where((place) =>
            place.city!.toLowerCase() ==
                suggestions[index].city!.toLowerCase())
                .toList();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SearchResult(placesfsearch: placesInCity),
              ),
            );
          },
        );
      },
    );
  }
}
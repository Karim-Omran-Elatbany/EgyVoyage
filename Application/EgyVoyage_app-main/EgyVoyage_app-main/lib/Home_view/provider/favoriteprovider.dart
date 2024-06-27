import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../Authentication/data/shared-preferences-service.dart';
import '../../Services/models/placesmodel.dart';


class FavoriteProvider extends ChangeNotifier {
  List<PlaceseModel> _favoritePlaces = [];
  List<PlaceseModel> get favoritePlaces => _favoritePlaces;

  final SharedPreferencesService _prefsService = SharedPreferencesService();

  Future<void> loadFavorites(String email) async {
    final favorites = await _prefsService.loadUserFavorites(email);
    _favoritePlaces = favorites;
    notifyListeners();
  }

  Future<void> toggleFavorite(PlaceseModel place, String email) async {
    final isExist = _favoritePlaces.any((element) => element.id == place.id);
    if (isExist) {
      _favoritePlaces.removeWhere((element) => element.id == place.id);
    } else {
      _favoritePlaces.add(place);
    }
    await _prefsService.saveUserFavorites(email, _favoritePlaces);
    notifyListeners();
  }

  bool isFavorite(PlaceseModel place) {
    return _favoritePlaces.any((element) => element.id == place.id);
  }

  Future<void> clearFavorites(String email) async {
    _favoritePlaces.clear();
    await _prefsService.saveUserFavorites(email, _favoritePlaces);
    notifyListeners();
  }

  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(context, listen: listen);
  }
}

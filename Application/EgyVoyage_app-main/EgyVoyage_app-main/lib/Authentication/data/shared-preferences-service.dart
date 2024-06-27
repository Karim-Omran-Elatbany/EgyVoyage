import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../Services/models/placesmodel.dart';

class SharedPreferencesService {
  Future<void> saveUserEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
  }

  Future<String?> loadUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }
  Future<void> saveUserData({
    required String fName,
    required String lName,
    required String phone,
    required String nationality,
    required String ssn,
    required String birthdate,
    required String email,
    required String password,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fName', fName);
    await prefs.setString('lName', lName);
    await prefs.setString('phone', phone);
    await prefs.setString('nationality', nationality);
    await prefs.setString('ssn', ssn);
    await prefs.setString('birthdate', birthdate);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  Future<Map<String, String>> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'fName': prefs.getString('fName') ?? '',
      'lName': prefs.getString('lName') ?? '',
      'phone': prefs.getString('phone') ?? '',
      'nationality': prefs.getString('nationality') ?? '',
      'ssn': prefs.getString('ssn') ?? '',
      'birthdate': prefs.getString('birthdate') ?? '',
      'email': prefs.getString('email') ?? '',
      'password': prefs.getString('password') ?? '',
    };
  }
  Future<void> saveUserFavorites(String email, List<PlaceseModel> favorites) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final favoritesJson = jsonEncode(favorites.map((place) => place.toJson()).toList());
    await prefs.setString('favorites_$email', favoritesJson);
  }

  Future<List<PlaceseModel>> loadUserFavorites(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getString('favorites_$email');
    if (favoritesJson != null) {
      final List<dynamic> favoriteList = jsonDecode(favoritesJson);
      return favoriteList.map((json) => PlaceseModel.fromJson(json)).toList();
    }
    return [];
  }
}

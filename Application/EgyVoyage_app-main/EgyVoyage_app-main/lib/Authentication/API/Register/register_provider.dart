import 'dart:convert';
import 'package:egyvoyage/Authentication/API/Register/register_response.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'app_urls.dart';
class RegisterProvider with ChangeNotifier {
  RegisterResponse registerResponse = RegisterResponse();
  int _statusCode = 0;
  bool isLoading = true;

  int get statusCode => _statusCode;

  set registerStatus(int value) {
    _statusCode = value;
  }

  registerUser(
      String fName,
      String lName,
      String gender,
      String phoneNumber,
      String nationality,
      String ssn,
      String birthdate,
      String email,
      String password,
      // String images,
      ) async {
    isLoading = true;
    notifyListeners();
    final Map<String, dynamic> registerData = {
      "fName": fName.trim(),
      "lName": lName.trim(),
      "gender":gender.trim(),
      "phoneNumber": phoneNumber.trim(),
      "nationality": nationality.trim(),
      "ssn": ssn.trim(),
      "birthdate": birthdate.trim(),
      "email": email.trim(),
      "password": password.trim(),
      // "images":null,
    };
    return await post(Uri.parse(AppUrls.BASE_URL),
        body: jsonEncode(registerData),
        headers: {
          'Content-Type': 'application/json',
        }).then(onValue).catchError(onError);
  }

  Future<void> onValue(Response response) async {
    String? result;

    final Map<String, dynamic> responseData = json.decode(response.body);
    registerResponse = RegisterResponse.fromJson(responseData);

    _statusCode = response.statusCode;
    if (response.statusCode == 200) {
      result = registerResponse.token;
      isLoading = false;
    } else {
      result = registerResponse.error;
      isLoading = false;
    }

    notifyListeners();
    return print(json.decode(response.body));
  }

  onError(error) async {
    return error;
  }
}
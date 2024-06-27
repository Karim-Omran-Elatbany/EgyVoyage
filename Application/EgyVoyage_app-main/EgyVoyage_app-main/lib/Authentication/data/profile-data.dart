import 'package:flutter/material.dart';

class UserDataProfile extends ChangeNotifier {
  String firstName = '';
  String lastName = '';
  String nationality = '';
  String birthDate = '';
  String phoneNumber = '';
  String password = '';
  String email = '';

  void updateData({
    required String firstName,
    required String lastName,
    required String nationality,
    required String birthDate,
    required String phoneNumber,
    required String password,
    required String email,
  }) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.nationality = nationality;
    this.birthDate = birthDate;
    this.phoneNumber = phoneNumber;
    this.password = password;
    this.email = email;

    notifyListeners();
  }
}

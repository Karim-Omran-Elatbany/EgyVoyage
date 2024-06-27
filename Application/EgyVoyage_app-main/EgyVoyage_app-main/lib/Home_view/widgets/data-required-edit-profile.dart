import 'package:flutter/cupertino.dart';

class UserData {
  late String firstName;
  late String lastName;
  late String phoneNumber;
  late String email;

  UserData({
    required TextEditingController fNameController,
    required TextEditingController lNameController,
    required TextEditingController phoneNumberController,
    required TextEditingController emailController,
  }) {
    initialize(
      fNameController: fNameController,
      lNameController: lNameController,
      phoneNumberController: phoneNumberController,
      emailController: emailController,
    );
  }

  void initialize({
    required TextEditingController fNameController,
    required TextEditingController lNameController,
    required TextEditingController phoneNumberController,
    required TextEditingController emailController,
  }) {
    firstName = fNameController.text;
    lastName = lNameController.text;
    phoneNumber = phoneNumberController.text;
    email = emailController.text;
  }
}

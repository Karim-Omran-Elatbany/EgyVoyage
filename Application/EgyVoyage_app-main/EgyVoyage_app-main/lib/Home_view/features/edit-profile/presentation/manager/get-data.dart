import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../view/editProfile_screen.dart';
class ApiClient {
  static const String apiUrl = 'http://egyvoyage2.somee.com/api/User/getuser';

  Future<Map<String, dynamic>> getUser(String email, String password) async {
    try {
      final url = Uri.parse('$apiUrl?email=${Uri.encodeComponent(email)}&password=${Uri.encodeComponent(password)}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response
        final responseData = jsonDecode(response.body);
        // Extract necessary data
        final firstName = responseData["fnmam"];
        final lastName = responseData["lname"];
        final userEmail = responseData["email"];
        final userPhoneNumber = responseData["phoneNumber"];

        // Store the response data
        final userData = {
          "firstName": firstName,
          "lastName": lastName,
          "email": userEmail,
          "phoneNumber": userPhoneNumber,

        };
        return userData;
      } else {
        // If the server returns an error response
        throw Exception('Failed to get user data');
      }
    } catch (e) {
      // If an error occurs during the request
      throw Exception('Failed to connect to the server: $e');
    }
  }

  void login(BuildContext context, String email, String password) async {
    try {
      final response = await http.get(
        Uri.parse('http://egyvoyage2.somee.com/api/User/getuser?email=${Uri.encodeComponent(email)}&password=${Uri.encodeComponent(password)}'),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());

        if (data is List && data.isNotEmpty) {
          Map<String, dynamic> userData = data[0];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(' successfully'),
              action: SnackBarAction(
                onPressed: () {},
                label: "DISMISS",
              ),
            ),
          );
          print(userData);
          Navigator.pushNamed(
            context,
            EditProfile.id,
            arguments: [
              {
                "firstName": userData["fnmam"],
                "lastName": userData["lname"],
                "email": userData["email"],
                "phoneNumber": userData["phoneNumber"],
              }
            ],
          );
        } else if (response.statusCode == 500) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Failed to get user data'),
              action: SnackBarAction(
                onPressed: () {},
                label: "DISMISS",
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Enter the email correctly'),
              action: SnackBarAction(
                onPressed: () {},
                label: "DISMISS",
              ),
            ),
          );
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }





}
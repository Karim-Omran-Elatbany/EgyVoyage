import 'package:bloc/bloc.dart';
import 'package:egyvoyage/Home_view/Screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  Future<void> editProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required BuildContext context, // Add context parameter here
  }) async {

    emit(EditProfileLoading());
    try {
      final url = Uri.parse(
          'http://egyvoyage2.somee.com/api/User/Edit?Email=$email');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'fName': firstName,
          'lName': lastName,
          'email': email,
          'phoneNumber': phoneNumber,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Navigator.of(context).pushNamed(HomePage.id);
        emit(EditProfileSuccess(responseBody: response.body));
        if (response.body.toLowerCase().contains('Succesful')) {
          print('Successful');
        }else if(response.statusCode == 500){
          emit(EditProfileFailure(errorMessage: response.body));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Failed to get user data'),
              action: SnackBarAction(
                onPressed: () {},
                label: "DISMISS",
              ),
            ),
          );
        }
        // } else {
        //   print('Response body does not contain "successful".');
        //   emit(EditProfileFailure(errorMessage: 'Failed to edit profile'));
        // }
      // } else {
      //   print('Failed to edit profile. Status code: ${response.statusCode}');
      //   emit(EditProfileFailure(errorMessage: 'Failed to edit profile'));
      }
    } catch (e) {
      // print('Error: $e');
      // emit(EditProfileFailure(errorMessage: 'Failed to edit profile: $e'));
    }
  }
}

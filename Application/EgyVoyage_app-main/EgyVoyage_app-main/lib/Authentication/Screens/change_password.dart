import 'dart:convert';
import 'package:egyvoyage/Authentication/Screens/password-correct.dart';
import 'package:egyvoyage/Authentication/data/profile-data.dart';
import 'package:egyvoyage/Home_view/features/edit-profile/presentation/view/widget/custom-appbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../CustomsWidget/custom_button.dart';
import '../../CustomsWidget/custom_textfield.dart';
import '../../Home_view/Screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../data/shared-preferences-service.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key});
  static String id = 'ChangePassword';

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _validate = false;
  bool _isObscure = true;
  bool _isPasswordEightCharacters = false;
  bool _hasPasswordOneNumber = false;

  void onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');

    setState(() {
      _isPasswordEightCharacters = password.length >= 8;
      _hasPasswordOneNumber = numericRegex.hasMatch(password);
    });
  }

  late TextEditingController emailController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;
  final _formKey = GlobalKey<FormState>();
  var data;
  Map<String, String> userData = {
    'fName': '',
    'lName': '',
    'phone': '',
    'nationality': '',
    'ssn': '',
    'birthdate': '',
    'email': '',
    'password': '',
  };

  Future<void> _loadUserData() async {
    SharedPreferencesService prefsService = SharedPreferencesService();
    Map<String, String> data = await prefsService.loadUserData();
    setState(() {
      userData = data;
    });
  }
  @override
  void initState() {
    super.initState();
    _loadUserData();
    emailController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void login(BuildContext context, String email) async {
    try {
      final String password = newPasswordController.text;

      final response = await http.get(
        Uri.parse('http://egyvoyage2.somee.com/api/User/change%20password?email=${Uri.encodeComponent(email)}&pass=${Uri.encodeComponent(password)}'),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Edit successfully'),
            action: SnackBarAction(
              onPressed: () {},
              label: "DISMISS",
            ),
          ),
        );
        print(data);
        Navigator.pushNamed(context, HomePage.id);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed'),
            action: SnackBarAction(
              onPressed: () {},
              label: "DISMISS",
            ),
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // UserDataProfile userDataProfile = Provider.of<UserDataProfile>(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBAr(),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/icon/reset-password.png',
                      height: 250,
                      width: 250,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Your New Password Must be unique from those Previously Used.',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // CustomFormTextField.customFormTextField(
                    //   controller: emailController,
                    //   textInputType: TextInputType.emailAddress,
                    //   preicon: const Icon(Icons.email, color: Colors.black),
                    //   hintText: 'Email',
                    //   obscureText: false,
                    //   errorText: _validate ? "Email Is Required" : null,
                    //   onChange: (data) {},
                    // ),
                    CustomFormTextField.customFormTextField(
                      controller: newPasswordController,
                      preicon: const Icon(Icons.lock, color: Colors.black),
                      hintText: 'Password',
                      errorText: _validate ? "Password should contain more than 5 characters" : null,
                      suicon: IconButton(
                        icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off, color: Colors.black),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      obscureText: _isObscure,
                      onChange: (data) => onPasswordChanged(data),
                      validator: (passwordController) {
                        if (!(passwordController!.length > 5) && passwordController.isNotEmpty) {
                          return "Password should contain more than 5 characters";
                        }
                        return null;
                      },
                    ),
                    CustomFormTextField.customFormTextField(
                      preicon: const Icon(Icons.lock,
                          color: Colors.black
                      ),
                      suicon: IconButton(
                        icon: Icon(_isObscure ? Icons.visibility :
                        Icons.visibility_off,
                            color: Colors.black
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      hintText: 'Confirm Password',
                      controller: confirmPasswordController,
                      obscureText: _isObscure,
                      onChange: (password) => onPasswordChanged(password),
                      validator: (confirmPassword) {
                        if (confirmPassword!.isEmpty) {
                          return 'Please enter confirm password';
                        }
                        if (confirmPassword != newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: _isPasswordEightCharacters ? Colors.green : Colors.transparent,
                              border: _isPasswordEightCharacters
                                  ? Border.all(color: Theme.of(context).textTheme.bodyText1?.color ?? Colors.black)
                                  : Border.all(color: Theme.of(context).textTheme.bodyText1?.color ?? Colors.black),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Icon(Icons.check, color: Theme.of(context).iconTheme.color, size: 15),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Contains at least 8 characters",
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: _hasPasswordOneNumber ? Colors.green : Colors.transparent,
                              border: _hasPasswordOneNumber
                                  ? Border.all(color: Colors.transparent)
                                  : Border.all(color: Theme.of(context).textTheme.bodyText1?.color ?? Colors.black),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Icon(Icons.check,
                                  color: Theme.of(context).iconTheme.color, size: 15),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Contains at least 1 number",
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      text: "Reset Password",
                      onPressed: () {
                        print(userData['email']!);
                        setState(() {
                          _validate = emailController.text.isEmpty || newPasswordController.text.isEmpty;
                        });
                        if (_formKey.currentState!.validate()) {
                          login(context,userData['email']!);
                          Navigator.of(context).pushNamed(PasswordCorrect.id);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

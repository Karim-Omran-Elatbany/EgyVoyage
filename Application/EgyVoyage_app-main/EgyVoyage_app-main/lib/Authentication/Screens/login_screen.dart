import 'dart:convert';
import 'package:egyvoyage/Authentication/Screens/register_screen.dart';
import 'package:egyvoyage/Home_view/features/edit-profile/presentation/view/widget/custom-appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Booking/widgets/custom_buttom.dart';
import '../../CustomsWidget/custom_textfield.dart';
import '../../Home_view/Screens/home_screen.dart';
import 'forget_password.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static String id = 'Login';

  @override
  State<Login> createState() => _LoginState();
}

class UserDataLogin with ChangeNotifier {
  String? email;
  String? password;

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }
}

class _LoginState extends State<Login> {
  bool? check1 = false;
  bool _validate = false;
  bool _isObscure = true;

  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://egyvoyage2.somee.com/api/User/signin?email=$email&password=$password'),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('emailLogin', emailController.text);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext ctx) => HomePage()));
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setString('email', email);
        // await prefs.setString('password', password);
        // Provider.of<UserDataLogin>(context, listen: false).setEmail(email);
        // Provider.of<UserDataLogin>(context, listen: false).setPassword(password);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Login successfully'),
            action: SnackBarAction(
              onPressed: () {},
              label: "DISMISS",
            ),
          ),
        );
        // Navigator.pushReplacementNamed(context, HomePage.id);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Login Failed'),
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
    final userData = Provider.of<UserDataLogin>(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBAr(),
              Column(
                children: [
                  const SizedBox(height: 24),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'EGYVOYAGE',
                        style: TextStyle(
                          fontSize: 42,
                          color: Color(0xff8e3200),
                          fontFamily: 'kGTSectraFine',
                        ),
                      ),
                    ],
                  ),
                   Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Welcome back ! ',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          // color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                   Text(
                    'Glad to See you Again ',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      // color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomFormTextField.customFormTextField(
                    preicon: Icon(
                      Icons.email,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    hintText: 'Email',
                    obscureText: false,
                    onChange: (data) {},
                    controller: emailController,
                    errorText: _validate ? "Email Is Required" : null,
                  ),
                  const SizedBox(height: 24),
                  CustomFormTextField.customFormTextField(
                    preicon: Icon(
                      Icons.lock,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    hintText: 'Password',
                    errorText: _validate
                        ? "Password should contain more than 5 characters"
                        : null,
                    suicon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                    obscureText: _isObscure,
                    onChange: (data) {},
                    controller: passwordController,
                    validator: (data) {
                      if (!(data!.length > 5) && data.isNotEmpty) {
                        return "Password should contain more than 5 characters";
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Checkbox(
                          activeColor: const Color(0xffdc800a),
                          checkColor: Colors.white,
                          value: check1,
                          onChanged: (bool? value) {
                            setState(() {
                              check1 = value;
                            });
                          },
                        ),
                         Text(
                          'Remember Me',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            // color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, ForgetPassword.id);
                          },
                          child: Text(
                            '  Forgot Password',
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomButton(
                    text: "Login",
                    onPressed: () async {

                      setState(() {
                        _validate = passwordController.text.isEmpty ||
                            emailController.text.isEmpty;
                      });
                      if (!_validate) {
                        await login(

                            emailController.text, passwordController.text);
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Register.id);
                        },
                        child: const Text(
                          '  Register',
                          style: TextStyle(
                            color: Color(0xff8e3200),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

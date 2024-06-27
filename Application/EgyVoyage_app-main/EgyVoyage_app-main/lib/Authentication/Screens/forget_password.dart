import 'dart:convert';
import 'package:egyvoyage/Authentication/Screens/otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Booking/widgets/custom_buttom.dart';
import '../../Constants/constant.dart';
import '../../CustomsWidget/custom_textfield.dart';
import '../../Home_view/features/edit-profile/presentation/view/widget/custom-appbar.dart';
import 'login_screen.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  static String id = 'ForgetPassword';

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool _validate = false;

  late TextEditingController emailController; // Moved the declaration here

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(); // Initialize the controller
  }

  void login() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://egyvoyage2.somee.com/api/User/ForgetPassword?email=${emailController.text}'),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        var code= data["code"];
        print(code);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('An Email has been sent'),
            action: SnackBarAction(
              onPressed: () {},
              label: "DISMISS",
            ),
          ),
        );
        Navigator.pushNamed(context, OtpVerification.id, arguments: code);
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
             const  CustomAppBAr(),
              Column(
                children: [
                  const SizedBox(height: 36,),
                  Image.asset('assets/icon/forgot.png',
                    height: 150,
                    width: 200
                    ,
                  ),
                  const SizedBox(height: 24,),
                   Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                         Text(
                          'Forgot Password?',
                           style:Theme.of(context).textTheme.bodyText1?.copyWith(
                             fontWeight: FontWeight.bold,
                             fontSize: 24,
                           ),
                          textAlign: TextAlign.start,
                        ),
                         const SizedBox(height: 24,),
                       const  Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Don\'t worry my friend! it occurs. Please enter the email address linked with your Account',
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
                  //email
                  CustomFormTextField.customFormTextField(
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,// Pass the controller
                    preicon: const Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    hintText: 'Email',
                    obscureText: false,
                    errorText:_validate ? "Email Is Required" :null,
                    onChange: (data) {},
                  ),
                  const SizedBox(height:24,),
                  CustomButton(
                    text: "Send",
                    onPressed: () {
                      setState(() {
                        _validate = emailController.text.isEmpty;
                      });
                      login();
              
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(
                        'Remember Password ?',
                        style:Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 16
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Login.id);
                        },
                        child: const Text(
                          '  Login',
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
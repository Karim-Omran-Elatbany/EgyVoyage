import 'package:egyvoyage/Home_view/features/edit-profile/presentation/view/widget/custom-appbar.dart';
import 'package:flutter/material.dart';
import '../../CustomsWidget/custom_button.dart';
import '../../CustomsWidget/custom_textfield.dart';
import 'change_password.dart';
class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key}) : super(key: key);
  static String id = 'OtpVerification';

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  TextEditingController otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    String? code = ModalRoute.of(context)!.settings.arguments as String;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const  CustomAppBAr(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.asset('assets/icon/otp2.jpg',
                        height: 250,
                        width: 300,
                      ),
                       Text(
                        textAlign: TextAlign.start,
                        'Verification Code ',
                        style:Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                      const SizedBox(height: 20,),
                      const Text(
                        'Enter The Verification Code  We just Sent on Your Email Address',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15,),
                      // OTP textfield
                      CustomFormTextField.customFormTextField(
                        controller: otpController,
                        textInputType: TextInputType.number,
                        preicon: const Icon(
                          Icons.code_sharp,
                          color: Colors.black,
                        ),
                        hintText: 'Code',
                        obscureText: false,
                        errorText: _validate ? "Code Is Required" : null,
                        onChange: (data) {},
                      ),
                      const SizedBox(height: 15,),
                      // Button
                      CustomButton(
                        text: "Verify",
                        onPressed: () {
                          setState(() {
                            _validate = otpController.text.isEmpty;
                          });
                          if (code == otpController.text) {
                            Navigator.pushNamed(context, ChangePassword.id);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Incorrect code, please try again.'),
                                action: SnackBarAction(
                                  onPressed: (){},
                                  label: "DISMISS",
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

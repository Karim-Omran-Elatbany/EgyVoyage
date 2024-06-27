import 'package:egyvoyage/Authentication/API/Register/register_provider.dart';
import 'package:egyvoyage/Authentication/data/profile-data.dart';
import 'package:egyvoyage/CustomsWidget/custom_textfield.dart';
import 'package:egyvoyage/Home_view/Screens/home_screen.dart';
import 'package:egyvoyage/Home_view/features/edit-profile/presentation/view/widget/custom-appbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:csc_picker/csc_picker.dart';
import '../../Constants/constant.dart';
import '../../CustomsWidget/custom_button.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  static String id = 'Register';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // late UserData userData;

  @override
  void initState() {
    super.initState();
    // userData = UserData(
    //   fNameController: fNameController,
    //   lNameController: lNameController,
    //   phoneNumberController: phoneNumberController,
    //   emailController: emailController,
    // );
  }

  bool _isVisible = false;
  bool _isPasswordEightCharacters = false;
  bool _hasPasswordOneNumber = false;
  bool _passwordsMatch = true;

  void onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');

    setState(() {
      _isPasswordEightCharacters = password.length >= 8;
      _hasPasswordOneNumber = numericRegex.hasMatch(password);
      _passwordsMatch = password == confirmPasswordController.text;
    });
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController ssnController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  String countryValue = "";
  bool _validate = false;
  bool _isObscure = true;
  String? valueChoose;
  List listItem = ["Male", "Female"];

  File? _pickedImage;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedImageFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
    }
  }

  Future<void> saveUserData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> uploadImage(File image, String email) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'http://egyvoyage2.somee.com/api/User/upload photo?email=${Uri.encodeComponent(email)}'),
    );
    request.files
        .add(await http.MultipartFile.fromPath('imagefile', image.path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fNameController.text = prefs.getString('fName') ?? '';
      lNameController.text = prefs.getString('lName') ?? '';
      phoneNumberController.text = prefs.getString('phone') ?? '';
      nationalityController.text = prefs.getString('nationality') ?? '';
      ssnController.text = prefs.getString('ssn') ?? '';
      birthdateController.text = prefs.getString('birthdate') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
    });
  }

  Future<void> printUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('First Name: ${prefs.getString('fName') ?? 'No First Name'}');
    print('Last Name: ${prefs.getString('lName') ?? 'No Last Name'}');
    print('Phone: ${prefs.getString('phone') ?? 'No Phone Number'}');
    print('Nationality: ${prefs.getString('nationality') ?? 'No Nationality'}');
    print('SSN: ${prefs.getString('ssn') ?? 'No SSN'}');
    print('Birthdate: ${prefs.getString('birthdate') ?? 'No Birthdate'}');
    print('Email: ${prefs.getString('email') ?? 'No Email'}');
    print('Password: ${prefs.getString('password') ?? 'No Password'}');
  }

  // Add listeners to text controllers to save data on change
  void _addListenerToController(TextEditingController controller, String key) {
    controller.addListener(() {
      saveUserData(key, controller.text);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _addListenerToController(fNameController, 'fName');
    _addListenerToController(lNameController, 'lName');
    _addListenerToController(phoneNumberController, 'phone');
    _addListenerToController(nationalityController, 'nationality');
    _addListenerToController(ssnController, 'ssn');
    _addListenerToController(birthdateController, 'birthdate');
    _addListenerToController(emailController, 'email');
    _addListenerToController(passwordController, 'password');
  }

  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<RegisterProvider>(context);
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
                    const SizedBox(
                      height: 28,
                    ),
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
                    Text('Welcome!',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 24, fontWeight: FontWeight.w900)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text('Create New Account',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                              fontSize: 24, fontWeight: FontWeight.w900)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: _pickImage,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor: Color(0xff8e3200),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: _pickedImage != null
                                    ? FileImage(_pickedImage!)
                                    : null,
                                child: _pickedImage == null
                                    ? Icon(
                                  Icons.person,
                                  size: 50,
                                  color:
                                  Theme.of(context).iconTheme.color,
                                )
                                    : null,
                              ),
                            ),
                            const Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: Color(0xff8e3200),
                                radius: 22,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormTextField.customFormTextField(
                      hintText: 'First Name',
                      onChange: (data) {},
                      textInputType: TextInputType.text,
                      controller: fNameController,
                      errorText: _validate ? "First Name Is Required" : null,
                    ),
                    CustomFormTextField.customFormTextField(
                      hintText: 'Last Name',
                      onChange: (data) {},
                      textInputType: TextInputType.text,
                      controller: lNameController,
                      errorText: _validate ? "Last Name Is Required" : null,
                    ),
                    CustomFormTextField.customFormTextField(
                      hintText: 'Phone',
                      preicon:
                      const Icon(Icons.phone_iphone, color: Colors.black),
                      onChange: (data) {},
                      textInputType: TextInputType.text,
                      controller: phoneNumberController,
                      errorText: _validate ? "Phone Is Required" : null,
                    ),
                    CustomFormTextField.customFormTextField(
                      hintText: 'SSN',
                      preicon:
                      const Icon(Icons.account_circle, color: Colors.black),
                      onChange: (data) {},
                      textInputType: TextInputType.text,
                      controller: ssnController,
                      errorText: _validate ? "SSN Is Required" : null,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.transparent,
                      ),
                      child: DropdownButton(
                        hint: Text(
                          'Select Gender',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontSize: 16),
                        ),
                        isExpanded: true,
                        underline: SizedBox(),
                        icon: Icon(Icons.arrow_drop_down,
                            color: Theme.of(context).iconTheme.color),
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        dropdownColor:Colors.grey,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontSize: 16),
                        focusColor: Colors.black,
                        borderRadius: BorderRadius.circular(24),
                        value: valueChoose,
                        onChanged: (newValue) {
                          setState(() {
                            valueChoose = newValue as String?;
                          });
                        },
                        items: listItem.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: CSCPicker(
                        flagState: CountryFlag.ENABLE,
                        disabledDropdownDecoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(30)),
                          color: kPrimaryColor,
                          border: Border.all(
                            color:
                            Theme.of(context).textTheme.bodyText1?.color ??
                                Colors.black,
                            width: 1,
                          ),
                        ),
                        dropdownDecoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(30)),
                          color: Colors.transparent,
                          border: Border.all(
                              color: Colors.black, width: 1),
                        ),
                        dropdownHeadingStyle:
                        const TextStyle(fontWeight: FontWeight.bold),
                        showCities: false,
                        showStates: false,
                        searchBarRadius: 50,
                        defaultCountry: CscCountry.Egypt,
                        countryDropdownLabel: countryValue,
                        onCountryChanged: (value) {
                          setState(() {
                            countryValue = value;
                          });
                        },
                      ),
                    ),
                    CustomFormTextField.customFormTextField(
                      hintText: 'Date of Birth',
                      errorText: _validate ? "Date of Birth Is Required" : null,
                      preicon:
                      const Icon(Icons.calendar_today, color: Colors.black),
                      controller: birthdateController,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime(1800),
                          firstDate: DateTime(1800),
                          lastDate: DateTime(2024, 3, 1),
                        );
                        if (pickedDate != null) {
                          String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            birthdateController.text = formattedDate;
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                    CustomFormTextField.customFormTextField(
                      preicon: const Icon(Icons.email, color: Colors.black),
                      hintText: 'Email',
                      obscureText: false,
                      onChange: (data) {},
                      textInputType: TextInputType.emailAddress,
                      controller: emailController,
                      errorText: _validate ? "Email Is Required" : null,
                    ),
                    CustomFormTextField.customFormTextField(
                      preicon: const Icon(Icons.lock, color: Colors.black),
                      onChange: (password) => onPasswordChanged(password),
                      hintText: 'Password',
                      errorText: _validate
                          ? "Password should contain more than 5 characters"
                          : null,
                      suicon: IconButton(
                        icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).iconTheme.color),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      obscureText: _isObscure,
                      controller: passwordController,
                      validator: (passwordController) {
                        if (!(passwordController!.length > 5) &&
                            passwordController.isNotEmpty) {
                          return "Password should contain more than 5 characters";
                        }
                        return null;
                      },
                    ),
                    CustomFormTextField.customFormTextField(
                      preicon: const Icon(Icons.lock, color: Colors.black),
                      suicon: IconButton(
                        icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).iconTheme.color),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      hintText: 'Confirm Password',
                      controller: confirmPasswordController,
                      onChange: (password) => onPasswordChanged(password),
                      validator: (confirmPassword) {
                        if (confirmPassword!.isEmpty) {
                          return 'Please enter confirm password';
                        }
                        if (confirmPassword != passwordController.text) {
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
                                color: _isPasswordEightCharacters
                                    ? Colors.green
                                    : Colors.transparent,
                                border: _isPasswordEightCharacters
                                    ? Border.all(color: Colors.transparent)
                                    : Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Icon(Icons.check,
                                  color: Theme.of(context).iconTheme.color,
                                  size: 15),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Contains at least 8 characters",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(fontSize: 16),
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
                                color: _hasPasswordOneNumber
                                    ? Colors.green
                                    : Colors.transparent,
                                border: _hasPasswordOneNumber
                                    ? Border.all(color: Colors.transparent)
                                    : Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Icon(Icons.check,
                                  color: Theme.of(context).iconTheme.color,
                                  size: 15),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Contains at least 1 number",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      text: "Register",
                      onPressed: () async {
                        UserDataProfile userDataProfile =
                        Provider.of<UserDataProfile>(context,
                            listen: false);
                        userDataProfile.updateData(
                          firstName: fNameController.text,
                          lastName: lNameController.text,
                          nationality: nationalityController.text,
                          birthDate: birthdateController.text,
                          phoneNumber: phoneNumberController.text,
                          password: passwordController.text,
                          email: emailController.text,
                        );
                        setState(() {
                          fNameController.text.isEmpty ||
                              lNameController.text.isEmpty ||
                              phoneNumberController.text.isEmpty ||
                              ssnController.text.isEmpty ||
                              birthdateController.text.isEmpty ||
                              emailController.text.isEmpty ||
                              passwordController.text.isEmpty
                              ? _validate = true
                              : _validate = false;
                        });
                        if (_formKey.currentState!.validate()) {
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            // userData.firstName = fNameController.text;
                            // userData.lastName = lNameController.text;
                            // userData.phoneNumber = phoneNumberController.text;
                            // userData.email = emailController.text;

                            final registerResponse =
                            registerProvider.registerUser(
                              fNameController.text,
                              lNameController.text,
                              valueChoose!,
                              phoneNumberController.text,
                              countryValue,
                              ssnController.text,
                              birthdateController.text,
                              emailController.text,
                              passwordController.text,
                            );
                            registerResponse.then((response) async {
                              if (registerProvider.statusCode == 200) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Register Successfully'),
                                  ),
                                );
                                // Print user data from SharedPreferences
                                await printUserData();
                                _pickedImage != null
                                    ? uploadImage(
                                    _pickedImage!, emailController.text)
                                    : null;
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString('emailLogin', emailController.text);
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (BuildContext ctx) => HomePage()));
                                // Navigator.pushNamed(context, HomePage.id);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Registration Failed"),
                                  ),
                                );
                              }
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Passwords do not match. Please enter matching passwords.'),
                              ),
                            );
                          }
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
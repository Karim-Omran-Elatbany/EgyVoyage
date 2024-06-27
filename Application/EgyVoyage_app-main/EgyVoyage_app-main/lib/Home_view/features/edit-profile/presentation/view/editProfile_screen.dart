import 'dart:io';
import 'package:egyvoyage/Authentication/data/shared-preferences-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:egyvoyage/CustomsWidget/custom_textfield.dart';
import 'package:egyvoyage/Home_view/Screens/home_screen.dart';
import 'package:egyvoyage/Home_view/features/edit-profile/presentation/manager/edit-profile-cubit/edit_profile_cubit.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../CustomsWidget/custom_button.dart';
import 'package:http/http.dart' as http;

import 'widget/custom-appbar.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key});
  static String id = 'EditProfile';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController fNameController;
  late TextEditingController lNameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  final formKey = GlobalKey<FormState>();
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
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


  Future<void> fetchImageUrl() async {
    if (userData['email'] == null || userData['email']!.isEmpty) {
      setState(() {
        imageUrl = ''; // Set to empty or default image URL if email is invalid
      });
      return;
    }

    try {
      final response = await http.get(Uri.parse(
          'http://egyvoyage2.somee.com/api/User/GetPHoto?email=${Uri.encodeComponent(userData['email']!)}'));
      if (response.statusCode == 200) {
        final String responseBody = response.body;
        if (responseBody.isNotEmpty && responseBody.startsWith('http')) {
          setState(() {
            imageUrl = responseBody;
          });
        } else {
          throw Exception('Invalid response format: $responseBody');
        }
      } else {
        throw Exception('Failed to load image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading image: $e');
      setState(() {
        imageUrl = ''; // Set to empty or default image URL in case of an error
      });
    }
  }
  String imageUrl = '';
  File? _pickedImage;
  final _picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    fNameController = TextEditingController();
    lNameController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    _loadUserData().then((_) => fetchImageUrl());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final dynamic arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null) {
      if (arguments is List<Map<String, dynamic>> && arguments.isNotEmpty) {
        final Map<String, dynamic>? userData = arguments.first;

        if (userData != null) {
          firstName = userData["firstName"] ?? '';
          lastName = userData["lastName"] ?? '';
          email = userData["email"] ?? '';
          phoneNumber = userData["phoneNumber"] ?? '';

          fNameController.text = firstName!;
          lNameController.text = lastName!;
          emailController.text = email!;
          phoneNumberController.text = phoneNumber!;
        }
      }
    }
  }

  @override
  void dispose() {
    lNameController.dispose();
    fNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

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
  Future<void> uploadImage(File image, String email) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://egyvoyage2.somee.com/api/User/upload photo?email=${Uri.encodeComponent(email)}'),
    );
    request.files.add(await http.MultipartFile.fromPath('imagefile', image.path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            const  CustomAppBAr(),
                  Form(
                    key: formKey,
                    child: BlocConsumer<EditProfileCubit, EditProfileState>(
                      listener: (context, state) {
                        if (state is EditProfileSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.responseBody),
                            ),
                          );
                          if (state.responseBody == 'Successful') {
                            Navigator.of(context).pushNamed(HomePage.id);
                          }
                        } else if (state is EditProfileFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Edit failed'),
                              action: SnackBarAction(
                                onPressed: () {},
                                label: "DISMISS",
                              ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          children: [
                            const SizedBox(height: 16),
                             Stack(
                               children: [
                                 GestureDetector(
                                   onTap: () {
                                     _pickImage(); // Add any additional logic you want to execute when tapping to pick an image
                                   },
                                   child: Stack(
                                     alignment: Alignment.bottomRight,
                                     children: [
                                       CircleAvatar(
                                         radius: 75,
                                         backgroundColor: Colors.white, // Set a background color for better visibility
                                         backgroundImage: _pickedImage != null
                                             ? FileImage(_pickedImage!)
                                             : (imageUrl.isNotEmpty
                                             ? NetworkImage(imageUrl)
                                             : AssetImage('assets/icon/avatar-2.jpg')) as ImageProvider<Object>?,
                                       ),
                                       const CircleAvatar(
                                         backgroundColor: Color(0xffd9e8ba),
                                         radius: 25,
                                         child: Icon(
                                           Icons.edit,
                                           size: 30,
                                           color: Color(0xff8e3200),
                                         ),
                                       ),
                                     ],
                                   ),
                                 )

                               ],
                             ),
                            const SizedBox(height: 50),
                            CustomFormTextField.customFormTextField(
                              hintText: 'First Name',
                              obscureText: false,
                              onChange: (data) {},
                              textInputType: TextInputType.text,
                              controller: fNameController,
                            ),
                            CustomFormTextField.customFormTextField(
                              hintText: 'Last Name',
                              obscureText: false,
                              onChange: (data) {},
                              textInputType: TextInputType.text,
                              controller: lNameController,
                            ),
                            CustomFormTextField.customFormTextField(
                              hintText: 'Email',
                              obscureText: false,
                              onChange: (data) {},
                              controller: emailController,
                            ),
                            CustomFormTextField.customFormTextField(
                              hintText: 'Phone',
                              obscureText: false,
                              onChange: (data) {},
                              textInputType: TextInputType.phone,
                              controller: phoneNumberController,
                            ),
                            const SizedBox(height: 24,),
                            CustomButton(
                              text: 'Save Changes',
                              onPressed: () {
                                _pickedImage != null ? uploadImage(_pickedImage!, emailController.text) : null;
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<EditProfileCubit>(context)
                                      .editProfile(
                                    firstName: fNameController.text,
                                    lastName: lNameController.text,
                                    email: emailController.text,
                                    phoneNumber: phoneNumberController.text,
                                    context: context,
                                  );
                                }
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}



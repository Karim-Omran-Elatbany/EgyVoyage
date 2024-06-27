import 'package:flutter/material.dart';

import '../widgets/custom_buttom.dart';
class EditPersonalDetails extends StatefulWidget {
  const EditPersonalDetails({super.key,required this.fname, required this.lname, required this.phone});
  final String fname;
  final String lname;
  final String phone;
  @override
  State<EditPersonalDetails> createState() => _EditPersonalDetailsState();
}

class _EditPersonalDetailsState extends State<EditPersonalDetails> {
  final _formKey = GlobalKey<FormState>();
  bool _isFirstNameValid = true;
  bool _isLastNameValid = true;
  bool _isPhoneValid = true;
  bool isChecked = false;
  TextEditingController fnameController=TextEditingController();
  TextEditingController lnameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  void _validateForm() {
    final isValid = _formKey.currentState!.validate();
    setState(() {
      // This setState call will ensure that the icons are updated based on the form validation
      _isFirstNameValid = _formKey.currentState!.validate();
      _isLastNameValid = _formKey.currentState!.validate();
      _isPhoneValid = _formKey.currentState!.validate();
      print('${[fnameController.text,lnameController.text]}');
      Navigator.of(context).pop([fnameController.text,lnameController.text,phoneController.text]);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fnameController.text=widget.fname;
    lnameController.text=widget.lname;
    phoneController.text=widget.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit your details')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    suffixIcon: Icon(
                      _isFirstNameValid ? Icons.check_circle : Icons.error,
                      color: _isFirstNameValid ? Colors.green : Colors.red,
                    ),
          
                  ),
                  style: const TextStyle(fontSize: 20),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _isFirstNameValid = value.isNotEmpty;
                    });
                  },
                  controller: fnameController,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    suffixIcon: Icon(
                      _isLastNameValid ? Icons.check_circle : Icons.error,
                      color: _isLastNameValid ? Colors.green : Colors.red,
                    ),
                  ),
                  style: const TextStyle(fontSize: 20),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _isLastNameValid = value.isNotEmpty;
                    });
                  },
                  controller: lnameController,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Mobile Phone',
                    suffixIcon: Icon(
                      _isPhoneValid ? Icons.check_circle : Icons.error,
                      color: _isPhoneValid ? Colors.green : Colors.red,
                    ),
                  ),
                  style: const TextStyle(fontSize: 20),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile phone';
                    }
                    // if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                    //   return 'Please enter a valid 10-digit phone number';
                    // }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _isPhoneValid = value.isNotEmpty ;
                      //&& RegExp(r'^\d{10}$').hasMatch(value)
                    });
                  },
                  controller: phoneController,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     const Text('Save your details for future bookings',
                //       style:  TextStyle(fontSize: 18),
                //     ),
                //     Checkbox(
                //       value: isChecked,
                //       onChanged: (bool? value) {
                //         setState(() {
                //           isChecked = value!;
                //         });
                //       },
                //       activeColor: Theme.of(context).colorScheme.secondary,
                //     )
                //   ],
                // ),
                const SizedBox(height: 30),
                Center(
                  child: CustomButton(
                    text: 'Save your details',
                    onPressed: _validateForm,
                  ),
                ),
          
              ],
            ),
          ),
        ),
      ),
    );
  }

}

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import '../../Constants/constant.dart';


class CountryPicker extends StatefulWidget {
  const CountryPicker({Key? key}) : super(key: key);

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  String countryValue = "";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical:5),
      child:Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(24),
            color: Colors.transparent),
        width:double.infinity,
        height:48,
        child:SingleChildScrollView(
          physics:null,
          child: Container(
            margin:  const EdgeInsets.all(0.6),
            child: CSCPicker(
              flagState: CountryFlag.ENABLE,
              disabledDropdownDecoration:
              BoxDecoration(
                // borderRadius: const BorderRadius.horizontal(
                //   left: Radius.circular(24),
                //   right: Radius.circular(24),),
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:kPrimaryColor,
                // border: Border.all(
                //   color:Colors.white,
                // ),
              ),
              dropdownHeadingStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold,
              ),
              selectedItemStyle: const TextStyle(color:Colors.white , fontSize: 16,fontWeight: FontWeight.bold),
              showCities: false,
              showStates: false,
              searchBarRadius: 60,
              currentCountry:'Egypt' ,
              defaultCountry: CscCountry.Egypt,
              dropdownDialogRadius: 30,
              countryDropdownLabel: countryValue,
              onCountryChanged: (value) {
                setState(() {
                  countryValue = value;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

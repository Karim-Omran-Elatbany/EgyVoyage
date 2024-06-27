import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpTextFormField extends StatelessWidget {
  const OtpTextFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 64, width: 60,
      child: TextFormField(

        cursorColor: Colors.deepPurple,
        onSaved: (pin1){
        },
        onChanged: (value){
          if(value.length==1 ){
            FocusScope.of(context).nextFocus();
          }
        },
        decoration:const InputDecoration(

          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder:  OutlineInputBorder(
            borderRadius:BorderRadius.horizontal(
              left: Radius.circular(24),
              right: Radius.circular(24),
            ),
            borderSide: BorderSide(
              color: Color(0xffe8da7e),
            ),
          ),
          enabledBorder:OutlineInputBorder(
            borderRadius:BorderRadius.horizontal(
              left: Radius.circular(24),
              right: Radius.circular(24),
            ),
            borderSide: BorderSide(color: Colors.white),
          )
        ),
        style:const TextStyle(color: Colors.white, fontSize: 24, // Theme.of(context).textTheme.headlineMedium,
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],

      ),
    );
  }
}
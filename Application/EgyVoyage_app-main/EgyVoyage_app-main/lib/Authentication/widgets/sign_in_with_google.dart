import 'package:flutter/material.dart';

class SignInWithGoogle extends StatelessWidget {
  const SignInWithGoogle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const  EdgeInsets.symmetric(horizontal: 20 ,vertical: 20),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(24),
            color: Colors.transparent),
        width:double.infinity,
        height:60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
                width: 40,
                height: 40,
                'assets/icon/google.png',
                fit:BoxFit.cover
            ),
            const SizedBox(width: 5.0,),
            const Text('Sign-in with Google', style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),

            )
          ],
        ),
      ),
    );
  }
}
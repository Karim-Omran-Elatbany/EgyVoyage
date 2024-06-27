import 'package:flutter/material.dart';
import 'login_screen.dart';

class PasswordCorrect extends StatelessWidget {
  const PasswordCorrect({super.key});
static String id = 'PasswordCorrect';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icon/approved_7498284.png',
            width: 100,
              height: 100,
            ),
            const SizedBox(height: 50,),
            const Text('Your Password has been',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 24,

            ),
            ),
           const  Text('Change Successfully',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 24,

              ),
            ),
            const SizedBox(height: 50,),
            MaterialButton(
              splashColor: Colors.white,
              focusColor: Colors.white,
              // hoverColor: kPrimaryColor,
              color:Colors.green,
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              height: 50,
              onPressed: (){
                Navigator.of(context).pushNamed(Login.id);
              },
              child:const  Text(
                'Back to login',
                style:  TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

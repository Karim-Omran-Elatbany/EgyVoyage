import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:egyvoyage/onboarding/view/onBoarding.dart';
import 'package:flutter/material.dart';

class SplashScreen  extends StatefulWidget {
  const SplashScreen ({Key? key}) : super(key: key);
  static String id = 'SplashScreen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder:(context){
            return OnboardingPage();
          }));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffdfdfd),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Center(
              child:Column(
                children: [
                  Image.asset('assets/onboarding/logo.png',
                    width: 300,
                    height: 300,
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText('Egy Voyage',
                          textStyle:const  TextStyle(
                            color: Color(0xff002b31),
                            fontSize: 30,
                            fontFamily: 'pacifico',
                          )),
                    ],
                    repeatForever: true,
                    onTap: () {
                      print("Egy Voyage");
                    },
                  ),
                  // SizedBox(height: 60,)
                ],
              )

          ),
        ],
      ),
    );
  }
}

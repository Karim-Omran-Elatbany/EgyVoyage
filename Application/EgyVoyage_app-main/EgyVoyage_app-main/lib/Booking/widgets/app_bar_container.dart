import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Constants/constant.dart';

class AppBarContainer extends StatelessWidget {
  const AppBarContainer({super.key,
    required this.child, this.title,
    this.implementLeading = false,
    this.titleString,
    this.implementTraling =false ,
  });
final Widget child ;
final Widget? title ;
  final String? titleString ;
final bool implementLeading ;
  final bool implementTraling ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:Stack(
       children: [
         SizedBox(height: 186,
         child: AppBar(
           centerTitle: true,
           automaticallyImplyLeading: false,
           elevation: 0,
           toolbarHeight: 90,
           backgroundColor:Colors.white,
            title: title ?? Row(
              children: [
                if(implementLeading)
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration:const  BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16),),
                        color: Colors.white,
                      ),
                      padding:const  EdgeInsets.all(10),
                      child:const  Icon(FontAwesomeIcons.arrowLeft, color: kPrimaryColor, size: 18,),
                    ),
                  ),
                Expanded(child:Column(
                  children: [
                    Text(titleString ?? '',style:const TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),
                  ],
                ),
                ),
                if(implementTraling)
                  Container(
                    decoration:const  BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16),),
                      color: Colors.white,
                    ),
                    padding:const  EdgeInsets.all(10),
                    child:const  Icon(FontAwesomeIcons.bars, color: kPrimaryColor, size: 16,),
                  ),
              ],
            ),
            flexibleSpace: Stack(
              children: [
                Container(
                  decoration:  BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset.topRight,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        kPrimaryColor.withOpacity(0.2),
                        kPrimaryColor.withOpacity(.9),
                      ],
                    ),
                    borderRadius:const BorderRadius.only(
                     bottomLeft: Radius.circular(35),),
                  ),
                ),
                Positioned(
                    child:Center(child: Image.asset('assets/images/Ancient_Egypt_Educational_Presentation_in_Yellow_Grey_Illustrative_Style-removebg-preview.png',
                      fit:BoxFit.fill,
                    ),
                    ),
                ),
              ],
            ),
         ),
         ),
         Container(
           margin: const EdgeInsets.only(top: 156,),
           child: child,
           padding:const EdgeInsets.symmetric( horizontal: 24,) ,
         ),
       ],
     ),
    );
  }
}

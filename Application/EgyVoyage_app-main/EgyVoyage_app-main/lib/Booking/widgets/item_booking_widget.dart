import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Constants/constant.dart';

class ItemBookingWidget extends StatelessWidget {
  const ItemBookingWidget({super.key, required this.icon, required this.title, required this.description, required this.onTap});
 final String icon ;
 final String title ;
 final String description ;
 final Function()? onTap ;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:const  EdgeInsets.all(10),
        decoration: BoxDecoration(
         border: Border.all(color: Colors.black12,),
          color:Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.all(Radius.circular(16),),
        ),
        child: Row(
          children: [
             Image.asset(icon ,width: 30, height: 30,),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style:const  TextStyle(),),
               const  SizedBox(height: 16,),
                Text(description,style:const  TextStyle( fontWeight: FontWeight.bold),),
              ],
            )
          ],
        ),
      ),
    );
  }
}

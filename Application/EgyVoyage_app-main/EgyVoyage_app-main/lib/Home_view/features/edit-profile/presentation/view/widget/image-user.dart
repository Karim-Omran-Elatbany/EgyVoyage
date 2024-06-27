import 'package:flutter/material.dart';

import '../../../../../../Constants/constant.dart';

class ImageUser extends StatelessWidget {
  const ImageUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: kPrimaryColor),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: 2,
                color: Colors.black.withOpacity(0.1),
              )
            ],
            shape: BoxShape.circle,
            image: const DecorationImage(
              image: AssetImage('assets/photo/Home/Colorful Gradient Background Man 3D Avatar.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 4, color: kPrimaryColor),
            color: Colors.white,
          ),
          child: IconButton(
            icon: const Icon(Icons.edit),
            color: kPrimaryColor,
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
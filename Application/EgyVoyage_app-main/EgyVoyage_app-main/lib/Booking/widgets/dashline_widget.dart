import 'package:flutter/material.dart';

import '../Constant/constant.dart';
class DashLineWidget extends StatelessWidget {
  const DashLineWidget({super.key,this.height=1,required this.color});
  final double height;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context,BoxConstraints constraints){
          final boxWidth=constraints.constrainWidth();
          const dashWidth=6.0;
          final dashHeight=height;
          final dashCount=(boxWidth/(2*dashWidth)).floor();
          return Padding(
            padding:const EdgeInsets.symmetric(vertical: kDefaultPadding),
            child:Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
              children: List.generate(dashCount, (_) {
                return SizedBox(
                  width: dashWidth,
                  height: dashHeight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: color),
                  ),
                );
              }

              ),
            ) ,
          );

        }
    );
  }
}

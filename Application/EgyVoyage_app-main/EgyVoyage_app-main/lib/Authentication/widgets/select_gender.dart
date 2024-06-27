// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class SelectGender extends StatefulWidget {
//   const SelectGender({Key? key}) : super(key: key);
//
//   @override
//   State<SelectGender> createState() => _SelectGenderState();
// }
//
// class _SelectGenderState extends State<SelectGender> {
//   String? valueChoose;
//
//   List listItem= ["Male", "Female"];
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin:const EdgeInsets.symmetric(horizontal: 20 ,vertical: 10),
//       width: double.infinity,
//       decoration: BoxDecoration(
//           border: Border.all(color: Colors.white),
//           borderRadius: BorderRadius.circular(24),
//           color: Colors.transparent),
//       child: DropdownButton(
//         hint: const Text('Select Gender',style: TextStyle(
//             color: Colors.white,
//             fontSize: 16
//         ),
//         ),
//         isExpanded: true ,
//         underline:const  SizedBox(),
//         icon:const Icon(Icons.arrow_drop_down ,color: Colors.white,),
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         dropdownColor:  const Color(0xff000814),
//         style: const  TextStyle(color:Colors.white ,fontSize: 16 ),
//         focusColor: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//         value: valueChoose,
//         onChanged:(newValue){
//           setState(() {
//             valueChoose= newValue as String?;
//           });
//         },
//         items: listItem.map((valueItem){
//           return DropdownMenuItem(
//             value: valueItem,
//             child: Text(valueItem),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

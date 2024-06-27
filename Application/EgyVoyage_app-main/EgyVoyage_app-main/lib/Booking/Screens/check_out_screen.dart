// import 'package:booking/Constant/constant.dart';
// import 'package:booking/data_models/room_model.dart';
// import 'package:booking/helpers/asset_helper.dart';
// import 'package:booking/screens/main_app.dart';
// import 'package:booking/widgets/app_bar_container.dart';
// import 'package:booking/widgets/custom_buttom.dart';
// import 'package:booking/widgets/item_room_booking_widget.dart';
// import 'package:flutter/material.dart';

// class CheckOutScreen extends StatelessWidget {
//   CheckOutScreen({super.key, required this.roomModel});

//   static const String id = '/check_out_Screen';
//   final RoomModel roomModel;

//   List<String> listStep = [
//     'Book and review',
//     'Payment',
//     'Confirm',
//   ];

//   Widget _buildItemOptionCheckout(
//       String icon, String title, String value, BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(kDefaultPadding),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(kDefaultPadding)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Image(
//                 image: AssetImage(icon),
//                 height: 32,
//                 width: 32,
//               ),
//               const SizedBox(
//                 width: kItemPadding,
//               ),
//               Text(
//                 title,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               )
//             ],
//           ),
//           const SizedBox(
//             height: kDefaultPadding,
//           ),
//           Container(
//             width: MediaQuery.of(context).size.width * 0.5,
//             decoration: BoxDecoration(
//                 color: kPrimaryColor.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(40)),
//             padding: const EdgeInsets.all(kMinPadding),
//             child: Row(
//               children: [
//                 Container(
//                   width: 40,
//                   height: 40,
//                   //  margin: EdgeInsets.all(2),
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(40)),
//                   child: const Icon(Icons.add),
//                 ),
//                 const SizedBox(
//                   width: kDefaultPadding,
//                 ),
//                 Text(
//                   value,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, color: kPrimaryColor),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildItemStepCheckout(
//       int step, String stepName, bool isEnd, bool isCheck) {
//     return Row(
//       children: [
//         Container(
//           width: kMediumPadding,
//           height: kMediumPadding,
//           decoration: BoxDecoration(
//               color: isCheck ? Colors.white : Colors.white.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(kMediumPadding)),
//           alignment: Alignment.center,
//           child: Text(
//             step.toString(),
//             style: TextStyle(color: isCheck ? Colors.black : Colors.white),
//           ),
//         ),
//         const SizedBox(
//           width: kMinPadding,
//         ),
//         Text(
//           stepName,
//           style: const TextStyle(color: Colors.white, fontSize: 11),
//         ),
//         const SizedBox(
//           width: kMinPadding,
//         ),
//         if (!isEnd)
//           const SizedBox(
//             width: kDefaultPadding,
//             child: Divider(
//               height: 1,
//               thickness: 1,
//               color: Colors.white,
//             ),
//           ),
//         if (!isEnd)
//           const SizedBox(
//             width: kMinPadding,
//           ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AppBarContainer(
//         titleString: "Checkout screen",
//         child: Column(
//           children: [
//             /*SizedBox(
//               height: kDefaultPadding,
//             ),*/
//             Row(
//               children: listStep
//                   .map((e) => _buildItemStepCheckout(
//                       listStep.indexOf(e) + 1,
//                       e,
//                       listStep.indexOf(e) == listStep.length - 1,
//                       listStep.indexOf(e) == 0))
//                   .toList(),
//             ),
//             const SizedBox(
//               height: kDefaultPadding,
//             ),
//             Expanded(
//                 child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   ItemRoomBookingWidget(
//                     roomImage: roomModel.roomImage,
//                     roomName: roomModel.roomName,
//                     roomPrice: roomModel.Price,
//                     roomsize: roomModel.size,
//                     roomUtility: roomModel.utility,
//                     onPressed: () {},
//                     numberofroom: 1,
//                   ),
//                   const SizedBox(
//                     height: kDefaultPadding,
//                   ),
//                   _buildItemOptionCheckout(AssetHelper.icoPromo,
//                       'Contact detail', 'Add contact', context),
//                   const SizedBox(
//                     height: kDefaultPadding,
//                   ),
//                   _buildItemOptionCheckout(AssetHelper.icoContact,
//                       'Promo code ', 'Add promo code', context),
//                   const SizedBox(
//                     height: kDefaultPadding,
//                   ),
//                   CustomButton(
//                     text: 'Payment',
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   const SizedBox(
//                     height: kMediumPadding,
//                   ),
//                 ],
//               ),
//             ))
//           ],
//         ));
//   }
// }

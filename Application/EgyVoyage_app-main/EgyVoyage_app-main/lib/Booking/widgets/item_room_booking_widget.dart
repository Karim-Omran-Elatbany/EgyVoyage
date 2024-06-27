import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Constant/constant.dart';
import '../data_models/room_model.dart';
import 'item_utility_hotel_widget.dart';

class ItemRoomBookingWidget extends StatelessWidget {
  ItemRoomBookingWidget({
    super.key,
    this.isSelected = true,
    required this.room,
    required this.onPressed,
    required this.nights
  });

  final Room room;
  final int nights;
  final void Function()? onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue.withOpacity(0.5)
              : Theme.of(context).colorScheme.surface ?? Colors.white,  // Changed to use theme color
          borderRadius: const BorderRadius.all(Radius.circular(kItemPadding)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        room.category,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis
                        ),
                      ),
                      const SizedBox(
                        height: kMinPadding,
                      ),
                      Text(
                        'Room capacity: ${room.capacity} person(s)',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: kMinPadding,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: kDefaultPadding * 2,
                ),
                Image.network(
                  room.image,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/room_1.jpg',
                        height: 70, width: 70, fit: BoxFit.cover);
                  },
                ),
              ],
            ),
            ItemUtilityHotelWidget(
              freeWifi: room.freeWifi,
              noSmoking: room.smoking,
              freeBreakfast: room.breakfast,
            ),
            const SizedBox(
              height: kMinPadding * 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$${room.price * nights}",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'for $nights night',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: onPressed,
                  child: Text(
                    "Choose",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

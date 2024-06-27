import 'dart:developer';
import 'package:egyvoyage/Booking/Screens/reservation_screen.dart';
import 'package:flutter/material.dart';

import '../../CustomsWidget/custom_button.dart';
import '../Constant/constant.dart';
import '../data_models/hotel_model.dart';
import '../data_models/room_model.dart';
import '../widgets/app_bar_container.dart';
import '../widgets/item_room_booking_widget.dart';

class SelectRoomScreen extends StatefulWidget {
  const SelectRoomScreen({Key? key}) : super(key: key);
  static const String id = '/select_room_screen';

  @override
  State<SelectRoomScreen> createState() => _SelectRoomScreenState();
}

class _SelectRoomScreenState extends State<SelectRoomScreen> {
  final Set<int> _selectedItems = <int>{};
  int _totalPrice = 0;
  int nights=1;
  void _updateSelection(Room room) {
    setState(() {
      if (_selectedItems.contains(room.id)) {
        _selectedItems.remove(room.id);
        _totalPrice -= room.price*nights;
        print('add roomid:${room.id}');
      } else {
        _selectedItems.add(room.id);
        _totalPrice += room.price*nights;
        print('remove roomid:${room.id}');

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    var model = args['hotelModel'] as HotelModel;
    List<Room> rooms = model.rooms;
    nights =args['nights'] as int ;


    return AppBarContainer(
      implementLeading: true ,
      titleString: 'Select room',
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: _selectedItems.isNotEmpty
                    ? 160
                    : 0), // Adjust padding dynamically
            child: Column(
              children: [
                const SizedBox(height: kMediumPadding * 2),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: rooms.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ItemRoomBookingWidget(
                        isSelected: _selectedItems.contains(rooms[index].id),
                        room: rooms[index],
                        nights: nights,
                        onPressed: () {
                          log(rooms[index].category);
                          _updateSelection(rooms[index]);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          if (_selectedItems.isNotEmpty)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(kDefaultPadding),
                decoration:  BoxDecoration(
                  color: Theme.of(context).colorScheme.surface ?? Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, // Adjusts to the height of its children
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_selectedItems.length} room(s) selected',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Total: \$ $_totalPrice',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    CustomButton(text: 'Reserve', onPressed: () {
                      Navigator.of(context).pushNamed(ReservationInfoScreen.id,
                          arguments: {
                            'rooms':_selectedItems.length,
                            'total':double.parse(_totalPrice.toString()),
                            'selectedRooms':_selectedItems
                          });
                    }),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

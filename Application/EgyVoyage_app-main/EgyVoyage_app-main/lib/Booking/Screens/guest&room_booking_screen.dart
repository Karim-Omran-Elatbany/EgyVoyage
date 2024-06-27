import 'package:flutter/material.dart';

import '../Constant/constant.dart';
import '../widgets/app_bar_container.dart';
import '../widgets/custom_buttom.dart';
class GuestRoomScreen extends StatefulWidget {
  const GuestRoomScreen({super.key});
  static String id='GuestRoomScreen';
  @override
  State<GuestRoomScreen> createState() => _GuestRoomScreenState();
}

class _GuestRoomScreenState extends State<GuestRoomScreen> {
  static int guest=2;
  static int room=1;
  late final TextEditingController _textEditingController;
  final FocusNode _focusNode=FocusNode();
  late final TextEditingController _textEditingController1;
  final FocusNode _focusNode1=FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController=TextEditingController(
        text: guest.toString())..addListener(() {guest=int.parse(_textEditingController.text); });
    _textEditingController1=TextEditingController(
        text: room.toString())..addListener(() {room=int.parse(_textEditingController1.text); });

  }
  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
        titleString: 'Add Person and Room',
        child: Column(
          children: [
            SizedBox(height: 80,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kTopPadding),
                color: Colors.white,
              ),
              margin: EdgeInsets.only(bottom: kMediumPadding),
              padding: EdgeInsets.all(kMediumPadding),
              child: Row(
                children: [
                  Image.asset('assets/images/guests.png',width: 40,height: 40,),
                  SizedBox(width: kDefaultPadding,),
                  Text('Person(s)'),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      if(guest>1){
                        setState(() {
                          guest--;
                          _textEditingController.text=guest.toString();
                          if(_focusNode.hasFocus){
                            _focusNode.unfocus();
                          }
                        });
                      }
                    },
                    child: Image.asset('assets/images/minus.png',width: 30,height: 30,),
                  ),
                  Container(
                    height: 35,
                    width: 60,
                    padding: EdgeInsets.only(left: 3),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: _textEditingController,
                      textAlign: TextAlign.center,
                      focusNode: _focusNode,
                      enabled: true,
                      autocorrect: false,
                      minLines: 1,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(bottom: 18)
                      ),
                      onChanged: (value){},
                      onSubmitted: (String submitValue){},
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        guest++;
                        _textEditingController.text=guest.toString();
                        if(_focusNode.hasFocus){
                          _focusNode.unfocus();
                        }
                      });
                    },
                    child: Image.asset('assets/images/add.png',width: 30,height: 30,),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kTopPadding),
                color: Colors.white,
              ),
              margin: EdgeInsets.only(bottom: kMediumPadding),
              padding: EdgeInsets.all(kMediumPadding),
              child: Row(
                children: [
                  Image.asset('assets/icon/hotel_booking_screen_room.png',width: 40,height: 40,),
                  SizedBox(width: kDefaultPadding,),
                  Text('Room(s)'),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      if(room>1){
                        setState(() {
                          room--;
                          _textEditingController1.text=room.toString();
                          if(_focusNode1.hasFocus){
                            _focusNode1.unfocus();
                          }
                        });
                      }
                    },
                    child: Image.asset('assets/images/minus.png',width: 30,height: 30,),
                  ),
                  Container(
                    height: 35,
                    width: 60,
                    padding: EdgeInsets.only(left: 3),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: _textEditingController1,
                      textAlign: TextAlign.center,
                      focusNode: _focusNode1,
                      enabled: true,
                      autocorrect: false,
                      minLines: 1,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(bottom: 18)
                      ),
                      onChanged: (value){},
                      onSubmitted: (String submitValue){},
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        room++;
                        _textEditingController1.text=room.toString();
                        if(_focusNode1.hasFocus){
                          _focusNode1.unfocus();
                        }
                      });
                    },
                    child: Image.asset('assets/images/add.png',width: 30,height: 30,),
                  )
                ],
              ),
            ),
            CustomButton(
              text: 'Done',
              onPressed: (){
                print('room=$room/guest=$guest');
                Navigator.of(context).pop([guest,room]);
              },
            ),


          ],
        )
    );
  }
}

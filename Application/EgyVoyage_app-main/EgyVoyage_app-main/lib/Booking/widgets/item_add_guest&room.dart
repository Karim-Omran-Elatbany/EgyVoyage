
import 'package:flutter/material.dart';

import '../Constant/constant.dart';
class ItemAddGuest extends StatefulWidget {
  const ItemAddGuest({super.key,required this.title,required this.icon, required this.innitdata});
  final String title;
  final String icon;
  final int innitdata;
  @override
  State<ItemAddGuest> createState() => _ItemAddGuestState();
}

class _ItemAddGuestState extends State<ItemAddGuest> {
  late final TextEditingController _textEditingController;
  final FocusNode _focusNode=FocusNode();
  late int number;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    number=widget.innitdata;
    _textEditingController=TextEditingController(
        text: widget.innitdata.toString())..addListener(() {number=int.parse(_textEditingController.text); });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kTopPadding),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(bottom: kMediumPadding),
      padding: EdgeInsets.all(kMediumPadding),
      child: Row(
        children: [
          Image.asset(widget.icon,width: 40,height: 40,),
          SizedBox(width: kDefaultPadding,),
          Text(widget.title),
          Spacer(),
          GestureDetector(
            onTap: (){
              if(number>1){
                setState(() {
                  number--;
                  _textEditingController.text=number.toString();
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
                number++;
                _textEditingController.text=number.toString();
                if(_focusNode.hasFocus){
                  _focusNode.unfocus();
                }
              });
            },
            child: Image.asset('assets/images/add.png',width: 30,height: 30,),
          )
        ],
      ),
    );
  }
}

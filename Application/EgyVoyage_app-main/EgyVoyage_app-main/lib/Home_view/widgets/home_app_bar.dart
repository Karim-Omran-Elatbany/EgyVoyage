
import 'package:dio/dio.dart';
import 'package:egyvoyage/Constants/constant.dart';
import 'package:egyvoyage/Home_view/Screens/search_screen.dart';
import 'package:flutter/material.dart';

import '../../Services/getplaces.dart';
import '../../Services/models/placesmodel.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  var searchcontroller=TextEditingController();
  List<PlaceseModel> names = [];
  List<PlaceseModel> filterednames = [];
  List<PlaceseModel>newsList = [];

  void getnames() async {
    newsList = await Placesservices(Dio()).getPlaces();
    /* List<String>places=[];
     for(var place in placeslist ){
       places.add(place['city']);
     }
     print (places);*/
    setState(() {
      names = newsList;
      filterednames = names;
    });
  }
  @override
  void initState() {
    getnames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const  EdgeInsets.symmetric(horizontal: 20,vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Container(
              padding:const  EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  boxShadow:const  [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6,
                    )
                  ],
                  borderRadius: BorderRadius.circular(15)),
              child:const  Icon(
                Icons.menu,
                size: 28,
                color: Colors.white,
              ),
            ),
          ),
          const   Row(
            children: [
              Icon(
                Icons.location_on,
                color: kPrimaryColor,
              ),
              Text(
                ' Egypt',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              )

            ],
          ),
          InkWell(
            onTap: () {
              showSearch(context: context,
                  delegate: SearchPage(newsList,names,filterednames)
              );
            },
            child: Container(
              padding:const  EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                boxShadow:const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 6,
                  ),],
                borderRadius: BorderRadius.circular(15),
              ),
              child:const  Icon(Icons.search,
                size: 28,
                color: Colors.white,
              ),
            ),
          )

        ],
      ),
    );
  }
}
/**/
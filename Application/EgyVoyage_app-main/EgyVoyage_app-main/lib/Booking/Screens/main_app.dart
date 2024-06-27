
import 'package:egyvoyage/Booking/Screens/reservartion_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../Constant/constant.dart';
import 'home_screen.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});
static String id ='MainApp';

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex =0 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
             _currentIndex=index ;
          });
            },
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kPrimaryColor.withOpacity(0.2),
        margin: const EdgeInsets.symmetric(horizontal:10 ,vertical: 10 ),
        items: [
          SalomonBottomBarItem(
              icon:const  Icon(FontAwesomeIcons.house,
              size: 18,
              ),
              title:const Text('Home'),
          ),

          SalomonBottomBarItem(
            icon:const  Icon(FontAwesomeIcons.history,
              size: 18,
            ),
            title:const Text('History'),
          ),

          SalomonBottomBarItem(
            icon:const  Icon(FontAwesomeIcons.briefcase,
              size: 18,
            ),
            title:const Text('Booking'),
          ),

          SalomonBottomBarItem(
            icon:const  Icon(FontAwesomeIcons.solidUser,
              size: 18,
            ),
            title:const Text('Profile'),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreenBooking(),
          ReservationHistoryScreen(),
          Container(color: Colors.orange,),
          Container(color: Colors.blue,),
        ],
      ),
    );
  }
}

import 'package:egyvoyage/Authentication/data/shared-preferences-service.dart';
import 'package:egyvoyage/Home_view/Screens/home_screen.dart';
import 'package:egyvoyage/Home_view/Screens/showfavoritelist.dart';
import 'package:egyvoyage/Home_view/features/chat-bot/presentation/view/chat-screen.dart';
import 'package:egyvoyage/Home_view/features/edit-profile/presentation/view/editProfile_screen.dart';
import 'package:egyvoyage/Splash/Screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Authentication/Screens/login_screen.dart';
import '../../Booking/Screens/hotel_booking_screen.dart';
import '../../Booking/Screens/reservartion_history_screen.dart';
import '../../provider/provider.dart';
import '../../weather/cubits/get_wether_cubit.dart';
import 'package:http/http.dart' as http;
import '../features/edit-profile/presentation/manager/get-data.dart';
import '../features/upload&capture-photo/presentation/view/upload&capture_photo.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  static TextStyle textStyle = TextStyle(fontSize: 20);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  String imageUrl = '';
  Map<String, String> userData = {
    'fName': '',
    'lName': '',
    'phone': '',
    'nationality': '',
    'ssn': '',
    'birthdate': '',
    'email': '',
    'password': '',
  };

  Future<void> _loadUserData() async {
    SharedPreferencesService prefsService = SharedPreferencesService();
    Map<String, String> data = await prefsService.loadUserData();
    setState(() {
      userData = data;
    });
  }

  Future<void> fetchImageUrl() async {
    if (userData['email'] == null || userData['email']!.isEmpty) {
      setState(() {
        imageUrl = ''; // Set to empty or default image URL if email is invalid
      });
      return;
    }

    try {
      final response = await http.get(Uri.parse(
          'http://egyvoyage2.somee.com/api/User/GetPHoto?email=${Uri.encodeComponent(userData['email']!)}'));
      if (response.statusCode == 200) {
        final String responseBody = response.body;
        if (responseBody.isNotEmpty && responseBody.startsWith('http')) {
          setState(() {
            imageUrl = responseBody;
          });
        } else {
          throw Exception('Invalid response format: $responseBody');
        }
      } else {
        throw Exception('Failed to load image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading image: $e');
      setState(() {
        imageUrl = ''; // Set to empty or default image URL in case of an error
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData().then((_) => fetchImageUrl());
  }
  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(userData['email']!);
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, SplashScreen.id, (route) => false);
  }
  @override
  Widget build(BuildContext context) {
    var fun = BlocProvider.of<GetWeatherCubit>(context);
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('${userData['fName']} ${userData['lName']} ', style: const TextStyle(fontSize: 20,color: Colors.white)),
            accountEmail: Text(userData['email'] ?? '', style: const TextStyle(fontSize: 20,color: Colors.white)),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: imageUrl.isNotEmpty
                    ? Image.network(
                  imageUrl,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.person, size: 50);
                  },
                )
                    : const Icon(Icons.person, size: 50),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('assets/photo/Home/pexels-tarek-hagrass-13420332.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            onDetailsPressed: () {
              if (userData['email'] != null && userData['password'] != null) {
                final apiClient = ApiClient();
                apiClient.login(
                    context, userData['email']!, userData['password']!);
              } else {
                // Handle case where email or password is not available
              }
              Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfile()));
            },
          ),
          Consumer<UiProvider>(
            builder: (context, notifier, child) {
              return ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text('Dark Mode'),
                trailing: Switch(
                  value: notifier.isDark,
                  onChanged: (value) {
                    notifier.changeTheme();
                  },
                  activeColor: notifier.isDark? Colors.white:Colors.black,
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.hotel),
            title: const Text('Book Hotels'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HotelBookingScreen(namedDestination: '')));
            },
          ),
          InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Showfavoritelist(),
                  ));
            },
            child:const  ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favourites'),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.upload),
            title: const Text('Upload Photo'),
            onTap: () {
              Navigator.pushNamed(context, CapturePhoto.id);
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('ChatBot'),
            onTap: () {
              Navigator.pushNamed(context, ChatScreen.id);
            },
          ),
           ListTile(
            leading: Icon(Icons.history),
            title: Text('Reservation History'),
            onTap: (){
              Navigator.pushNamed(context, ReservationHistoryScreen.id);
            },
          ),
          ListTile(
            leading: const Icon(Icons.air),
            title: const Text('Weather'),
            onTap: () async {
              Position position = await determinePosition();
              double longitude = position.longitude;
              double latitude = position.latitude;
              String cityName = '$latitude,$longitude';
              print('$latitude,$longitude');
              fun.getWeather(cityName: cityName);
              Navigator.pushReplacementNamed(context, 'HomeView');
            },
          ),
          // const ListTile(
          //   leading: Icon(Icons.contact_support),
          //   title: Text('Contact Us'),
          // ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: ()async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('emailLogin');
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext ctx) => Login()));
            },
          ),
        ],
      ),
    );
  }
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

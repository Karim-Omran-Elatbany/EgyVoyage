import 'package:egyvoyage/Authentication/Screens/password-correct.dart';
import 'package:egyvoyage/Authentication/data/shared-preferences-service.dart';
import 'package:egyvoyage/Home_view/Screens/home_screen.dart';
import 'package:egyvoyage/Home_view/features/edit-profile/presentation/view/editProfile_screen.dart';
import 'package:egyvoyage/Splash/Screens/splash_screen.dart';
import 'package:egyvoyage/provider/provider.dart';
import 'package:egyvoyage/weather/cubits/get_wether_cubit.dart';
import 'package:egyvoyage/weather/views/details_view.dart';
import 'package:egyvoyage/weather/views/home_view.dart';
import 'package:egyvoyage/weather/views/search_view.dart';
import 'package:egyvoyage/weather/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Authentication/API/Register/register_provider.dart';
import 'Authentication/Screens/change_password.dart';
import 'Authentication/Screens/forget_password.dart';
import 'Authentication/Screens/login_screen.dart';
import 'Authentication/Screens/otp_verification.dart';
import 'Authentication/Screens/register_screen.dart';
import 'Authentication/data/profile-data.dart';
import 'Booking/Constant/globals.dart';
import 'Booking/Screens/book_details_screen.dart';
import 'Booking/Screens/guest&room_booking_screen.dart';
import 'Booking/Screens/hotel_booking_screen.dart';
import 'Booking/Screens/hotel_detail_screen.dart';
import 'Booking/Screens/main_app.dart';
import 'Booking/Screens/reservartion_history_screen.dart';
import 'Booking/Screens/reservation_screen.dart';
import 'Booking/Screens/select_date_screen.dart';
import 'Booking/Screens/select_room_screen.dart';
import 'Booking/data_models/hotel_model.dart';
import 'Home_view/Screens/feedback_screen.dart';
import 'Home_view/features/chat-bot/presentation/view/chat-screen.dart';
import 'Home_view/features/edit-profile/presentation/manager/edit-profile-cubit/edit_profile_cubit.dart';
import 'Home_view/features/upload&capture-photo/presentation/view/upload&capture_photo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Home_view/provider/favoriteprovider.dart';
String? email = '';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  email = prefs.getString('emailLogin');
  if (email == null) {
    await saveUserEmail('emailLogin');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDataLogin()),
        ChangeNotifierProvider(create: (_) => UserDataProfile()),
        ChangeNotifierProvider(create: (_) => UiProvider()),
      ],
      child: const EgyVoyage(),
    ),
  );
  getCurrentLocation();
}

Future<void> saveUserEmail(String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('emailLogin', email);
}


class EgyVoyage extends StatefulWidget {
  const EgyVoyage({Key? key}) : super(key: key);

  @override
  State<EgyVoyage> createState() => _EgyVoyageState();
}

class _EgyVoyageState extends State<EgyVoyage> {
  // bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    // _checkAuthentication();
  }


  // Future<void> _checkAuthentication() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? email = prefs.getString('emailLogin');
  //   setState(() {
  //     _isAuthenticated = email != null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegisterProvider()),
        BlocProvider(create: (context) => EditProfileCubit()),
        BlocProvider(create: (context) => GetWeatherCubit()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: ChangeNotifierProvider(
        create: (BuildContext context) => UiProvider()..init(),
        child: Consumer<UiProvider>(
          builder: (context, UiProvider notifier, child) {
            return MaterialApp(
              theme: notifier.lightTheme,
              darkTheme: notifier.darkTheme,
              themeMode: notifier.isDark ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              routes: {
                SplashScreen.id: (context) => const SplashScreen(),
                Register.id: (context) => const Register(),
                ForgetPassword.id: (context) => const ForgetPassword(),
                ChangePassword.id: (context) => const ChangePassword(),
                Login.id: (context) => const Login(),
                OtpVerification.id: (context) => const OtpVerification(),
                HomePage.id: (context) => HomePage(),
                CapturePhoto.id: (context) => const CapturePhoto(),
                BookDetailsScreen.id: (context) => const BookDetailsScreen(),
                MainApp.id: (context) => const MainApp(),
                HotelBookingScreen.id: (context) => const HotelBookingScreen(namedDestination: ''),
                SelectDateScreen.id: (context) => SelectDateScreen(),
                GuestRoomScreen.id: (context) => const GuestRoomScreen(),
                SelectRoomScreen.id: (context) => SelectRoomScreen(),
                FeedbackScreen.id: (context) => FeedbackScreen(email: "", hotelId: ""),
                EditProfile.id: (context) => const EditProfile(),
                ChatScreen.id: (context) => const ChatScreen(),
                PasswordCorrect.id: (context) => const PasswordCorrect(),
                ReservationHistoryScreen.id: (context) => ReservationHistoryScreen(),
                'SplashView': (context) => const SplashView(),
                'HomeView': (context) => const HomeView(),
                'SearchView': (context) => SearchView(),
                'DetailsView': (context) => const DetailsView(),
              },
              home: email == null ? SplashScreen() : HomePage(),
              onGenerateRoute: generateRoutes,
            );
          },
        ),
      ),
    );
  }
}
MaterialPageRoute<dynamic>? generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case HotelDetailScreen.id:
      return MaterialPageRoute(builder: (context) {
        final args = settings.arguments as Map<String, dynamic>;
        final HotelModel hotelModel = args['hotelModel'] as HotelModel;
        final int nights = args['nights'] as int;
        return HotelDetailScreen(hotelModel: hotelModel, nights: nights);
      });
    case ReservationInfoScreen.id:
      return MaterialPageRoute(builder: (context) {
        final args = settings.arguments as Map<String, dynamic>;
        final int rooms = args['rooms'] as int;
        final double total = args['total'] as double;
        final Set<int> selectedRooms = args['selectedRooms'] as Set<int>;
        return ReservationInfoScreen(numberOfRooms: rooms, totalPrice: total, roomIds: selectedRooms);
      });
  }
  return null;
}

Future<void> requestLocationPermission() async {
  PermissionStatus status = await Permission.location.request();
  if (status == PermissionStatus.granted) {
    print('Location permission granted');
  } else if (status == PermissionStatus.denied) {
    print('Location permission denied');
  } else {
    print('Location permission permanently denied');
  }
}

Future<void> getCurrentLocation() async {
  await requestLocationPermission();
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  globalCurrentLat = position.latitude;
  globalCurrentLong = position.longitude;
  print("current lat:$globalCurrentLat");
  print("current long:$globalCurrentLong");
}

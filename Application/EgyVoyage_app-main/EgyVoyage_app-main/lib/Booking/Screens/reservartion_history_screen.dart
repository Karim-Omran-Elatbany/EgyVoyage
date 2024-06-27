import 'package:dio/dio.dart';
import 'package:egyvoyage/Home_view/Screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../../Authentication/data/shared-preferences-service.dart';
import '../data_models/reservationHistory_model.dart';
import '../widgets/reservation_widget.dart';

class ReservationHistoryScreen extends StatefulWidget {
  @override
  static String id = 'ReservationHistoryScreen';
  _ReservationHistoryScreenState createState() => _ReservationHistoryScreenState();
}

class _ReservationHistoryScreenState extends State<ReservationHistoryScreen> {
  late Future<List<ReservationHistoryModel>> reservations;
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

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferencesService prefsService = SharedPreferencesService();
    Map<String, String> data = await prefsService.loadUserData();
    setState(() {
      userData = data;
      reservations = fetchReservationHistory(userData['email']!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));
        return Future(() => true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reservation History'),
          leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));
          },),
        ),
        body: FutureBuilder<List<ReservationHistoryModel>>(
          future: reservations,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No reservations found.'));
            } else {
              List<ReservationHistoryModel> reservations = snapshot.data!;
              return ListView.builder(
                itemCount: reservations.length,
                itemBuilder: (context, index) {
                  return ReservationWidget(reservation: reservations[index],email: userData['email']!,);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

Future<List<ReservationHistoryModel>> fetchReservationHistory(String email) async {
  final String apiUrl = 'http://egyvoyage2.somee.com/api/Receipt?email=$email';

  Dio dio = Dio();

  try {
    final response = await dio.post(apiUrl);

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      List<ReservationHistoryModel> reservations = data.map((json) => ReservationHistoryModel.fromJson(json)).toList();
      return reservations.reversed.toList(); // Reverse the list before returning
    } else {
      print('Failed to fetch reservation history: ${response.statusCode}');
      return [];
    }
  } on DioError catch (e) {
    print('Error fetching reservation history: ${e.message}');
    return [];
  }
}

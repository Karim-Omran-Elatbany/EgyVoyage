import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:egyvoyage/Booking/Screens/reservartion_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this package for date formatting
import '../../Authentication/data/shared-preferences-service.dart';
import '../../CustomsWidget/custom_button.dart';
import '../Constant/constant.dart';
import '../Constant/globals.dart';
import '../helpers/image_helper.dart';
import 'edit_personal_details_screen.dart';

class ReservationInfoScreen extends StatefulWidget {
  static const String id = 'ReservationScreen';
  final int numberOfRooms;
  final double totalPrice;
  final Set<int> roomIds;

  ReservationInfoScreen({
    Key? key,
    required this.numberOfRooms,
    required this.totalPrice,
    required this.roomIds,
  }) : super(key: key);

  @override
  State<ReservationInfoScreen> createState() => _ReservationInfoScreenState();
}

class _ReservationInfoScreenState extends State<ReservationInfoScreen> {
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
    Future<void> fetchUserData(String email, String password) async {
    final String url = 'http://egyvoyage2.somee.com/api/User/getuser?email=$email&password=$password';
    final Dio dio = Dio();
    print('email:$email, password: $password');
    try {
      final response = await dio.get(url);
      print(url);

      if (response.statusCode == 200) {
        final data = response.data;
        setState(() {
          userData['fName'] = data[0]['fnmam'].toString() ?? '';
          userData['lName'] = data[0]['lname'].toString() ?? '';
          userData['phone'] = data[0]['phoneNumber'].toString() ?? '';
        });
        print('User data fetched and set successfully.');
      } else {
        print('Failed to load user data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
  Future<void> _loadUserData() async {
    SharedPreferencesService prefsService = SharedPreferencesService();
    Map<String, String> data = await prefsService.loadUserData();
    userData=data;
    await fetchUserData(userData['email']!, userData['password'].toString()!);
    print('user:${data}');
  }

  String processNum = "0000000000";
  String pinCode = "123456";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                  child: ImageHelper.loadFromNetwork(
                      globalHotelModel.image,
                      width: double.infinity,
                      height: 200,
                      radius: BorderRadius.circular(15.0))),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    globalHotelModel.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.visible
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 30,
                  ),
                  const SizedBox(
                    width: kMinPadding,
                  ),
                  Text(
                    globalHotelModel.rating.toString(),
                    style: const TextStyle(fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                height: kDefaultPadding,
              ),
              const SizedBox(height: 16),
              Table(
                children: [
                  TableRow(
                    decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kPrimaryColor
                    ),
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Check-in Date',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Check-out Date',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          globalStart,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          globalEnd,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: kDefaultPadding,
              ),
              const SizedBox(height: kDefaultPadding),
              Text(
                'Number of Rooms: ${widget.numberOfRooms}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Total Price: \$${widget.totalPrice}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
               Divider(
                color: Theme.of(context).textTheme.bodyText1?.color ?? Colors.black,
              ),
              const Text(
                'Your personal details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text(
                    "${userData['fName']}, ${userData['lName']}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const Spacer(),
                  TextButton(
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold,
                           color:kPrimaryColor,
                      ),
                    ),
                    onPressed: () async {
                      final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditPersonalDetails(
                                fname: userData['fName'] ?? '',
                                lname: userData['lName'] ?? '',
                                phone: userData['phone'] ?? '',
                              )));
                      if (result != null) {
                        setState(() {
                          userData['fName'] = result[0];
                          userData['lName'] = result[1];
                          userData['phone']!=result[2];

                        });
                        print("${userData['fName']}, ${userData['lName']}");
                      }
                    },
                  )
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: CustomButton(
                  text: 'Confirm Reservation',
                  onPressed: ()async{
                    final bool result=await sendReservationData(
                        email: userData['email']!,
                        name: '${userData['fName']} ${userData['lName']}',
                        roomIds: widget.roomIds,
                        startDate: globalStart,
                        endDate: globalEnd);
                    if(result){
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.scale,
                        headerAnimationLoop: false,
                        dialogType: DialogType.success,
                        showCloseIcon: true,
                        title: 'Reservation Successful',
                        desc: 'Confirmation number:$processNum \n Pin code:$pinCode',
                        btnOkOnPress: () {
                          Navigator.of(context).pushNamed(ReservationHistoryScreen.id);
                        },

                      ).show();
                    }

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> sendReservationData({
    required String email,
    required String name,
    required Set<int> roomIds,
    required String startDate,
    required String endDate,
  }) async {
    final String apiUrl = 'http://egyvoyage2.somee.com/api/Reservation/reserv';

    Dio dio = Dio();
    var data={
      "email": email,
      "name": name,
      "roomId": roomIds.toList(),
      "start": startDate,
      "end": endDate,
    };
    try {
      final response = await dio.post(
        apiUrl,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Reservation successful: ${response.data}');
        processNum=response.data['num_process'].toString();
        pinCode=response.data['pincode'].toString();
        return true;

      } else {
        print('Failed to make reservation: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print('Error sending reservation: ${e.message}');
      print(data);

      if (e.response != null) {
        print('Error details: ${e.response?.data}');
      }
    }
    return false;
  }
}
String formatDate(DateTime date) {
  return DateFormat('EEE, d MMM yyyy').format(date);
}


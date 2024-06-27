import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:egyvoyage/Home_view/Screens/feedback_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Constants/constant.dart';
import '../../CustomsWidget/custom_button.dart';
import '../Screens/reservartion_history_screen.dart';
import '../data_models/reservationHistory_model.dart';

class ReservationWidget extends StatelessWidget {
  final ReservationHistoryModel reservation;
  final String email;
  ReservationWidget({required this.reservation,required this.email});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime startDate = DateTime.parse(reservation.start);
    DateTime endDate = DateTime.parse(reservation.end);

    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration:  BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              reservation.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/images/hotel.png',fit: BoxFit.cover);
              },
            ),
          ),
          const SizedBox(height: 10),
          Text(
            reservation.hotelName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            'Name: ${reservation.name}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 5),
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
                      '${reservation.start.substring(0,10)}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${reservation.end.substring(0,10)}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            'Total Price: \$${reservation.totalPrice}',
            style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            'Confirmation Number: ${reservation.processNumber}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 5),
          Text(
            'Pin Code: ${reservation.pinCode}',
            style: const TextStyle(fontSize: 18),
          ),
          if (endDate.isBefore(now) || areDatesEqualIgnoringTime(endDate, now))
            CustomButton(text: 'Rate us',onPressed: (){
              // TODO
              // navigate to feedback
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedbackScreen(email: email, hotelId: reservation.hotelId)));
            },),
          if (startDate.isAfter(now)|| areDatesEqualIgnoringTime(startDate, now))
            CustomButton(text: 'Cancel reservation',onPressed: (){
              // TODO
              // Handle cancel reservation logic
              _showCancelDialog(context, email: email, id: reservation.id);

            },)
        ],
      ),
    );
  }
  void _showCancelDialog(BuildContext context,{required String email,required int id}) {
    showDialog(
      context: context,
      builder: (BuildContext dialougcontext) {
        return AlertDialog(
          title: Text('Cancel Reservation'),
          content: Text('Are you sure you want to cancel this reservation?',style: const TextStyle(fontSize: 18),),
          actions: <Widget>[
            TextButton(
              onPressed: () async{
                // Add your cancel reservation logic here
                bool isCanceled=await cancelReservation(id, email);
                Navigator.of(dialougcontext).pop();
                print('canceld:$isCanceled');
                // Handle the cancel action
                if(isCanceled) {
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.scale,
                    headerAnimationLoop: false,
                    dialogType: DialogType.success,
                    title: 'Reservation cancelled successfully.',
                    desc: 'you will recive a cancellation email soon',
                    showCloseIcon: true,
                    btnOkOnPress: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ReservationHistoryScreen()));
                    },
                  ).show();

                }

              },
              child: Text('Yes',style: const TextStyle(fontSize: 18,color: Colors.blue),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No',style: const TextStyle(fontSize: 18,color: Colors.blue),),
            ),
          ],
        );
      },
    );
  }
  Future<bool> cancelReservation(int id, String email) async {
    final String apiUrl = 'http://egyvoyage2.somee.com/api/Reservation';

    Dio dio = Dio();

    try {
      final response = await dio.delete(
        apiUrl,
        queryParameters: {
          'id': id,
          'mail': email,
        },
      );

      if (response.statusCode == 200) {
        print('Reservation cancelled successfully: ${response.data}');
        return true;
      } else {
        print('Failed to cancel reservation: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print('Error cancelling reservation: ${e.message}');
      if (e.response != null) {
        print('Error details: ${e.response?.data}');
      }
    }
    return false;
  }
  bool areDatesEqualIgnoringTime(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
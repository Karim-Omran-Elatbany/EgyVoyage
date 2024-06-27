import 'package:dio/dio.dart';
import 'package:egyvoyage/Booking/widgets/custom_buttom.dart';
import 'package:emoji_rating_bar/emoji_rating_bar.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  final String hotelId;
  final String email;
  FeedbackScreen({super.key,required this.email, required this.hotelId});
  static String id = 'FeedbackScreen';

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  double rate=0;
  bool isChanged=false;
  TextEditingController commentController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('email:${widget.email} \nhotel:${widget.hotelId}');
    return Scaffold(
      appBar: AppBar(leading: IconButton(icon:const  Icon(Icons.arrow_back_ios),color: Colors.black,
        onPressed: (){
        Navigator.pop(context);
        },
      ),backgroundColor: Colors.white,elevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const  Text('Feedback',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            const  SizedBox(height: 20,),
            const Text('How would you rate your experience?',style: TextStyle(fontSize: 18),),
            const SizedBox(height: 18,),
            Container(
              width: double.infinity,
              child: EmojiRatingBar(
                onRateChange: (rating) {
                  rate=rating;
                  isChanged=true;
                  print(rating);
                },
                isReadOnly: false,
                spacing: 20,
                size: 40,
                selectedSize: 50,
                isShowTitle: false,
                isShowDivider: false,
                titleStyle:const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                selectedTitleStyle:const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
                animationCurve: Curves.easeInOut,
                ratingBarType: RatingBarType.feedback,
                applyColorFilter : true,
              ),
            ),
            const Row(
              children: [
                Text('Comment ',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                Text('(optional)',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),
            const SizedBox(height:20 ,),
            Container(
              width: double.infinity,
              height: 150,
              padding:const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black,
                      width: 1
                  ),
                  borderRadius: BorderRadius.circular(18)
              ),
              child:TextField(
                controller: commentController,
                expands: true,
                maxLines: null,
                decoration: InputDecoration(
                    hintText: 'Enter your feedback here',
                    border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const Spacer(flex: 1,),
            CustomButton(text: 'Send Feedback',
            onPressed: () async{
              if(isChanged){
                bool success = await sendFeedback(
                  hotelId: widget.hotelId,
                  email: widget.email,
                  description: commentController.text,
                  rating: rate*2,
                );

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Feedback sent successfully!')),
                  );
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to send feedback.')),
                  );
                }

              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please choose a rating first'),
                  ),
                );
              }
            },
            ),
            const Spacer(flex: 6,),

          ],
        ),
      ),

    );
  }
  Future<bool> sendFeedback({
    required String hotelId,
    required String email,
    required String description,
    required double rating,
  }) async {
    final String apiUrl = 'http://egyvoyage2.somee.com/api/FeedBack?hotel_id=$hotelId';

    Dio dio = Dio();

    try {
      final response = await dio.post(
        apiUrl,
        data: {
          "email": email,
          "description": description,
          "rating": rating,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Feedback sent successfully: ${response.data}');
        return true;
      } else {
        print('Failed to send feedback: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print('Error sending feedback: ${e.message}');
      if (e.response != null) {
        print('Error details: ${e.response?.data}');
      }
    }
    return false;
  }
}

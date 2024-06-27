import 'package:egyvoyage/Constants/constant.dart';
import 'package:flutter/material.dart';

class BookDetailsScreen extends StatelessWidget {

  // String ? image;
  // String ? text;
   const BookDetailsScreen({super.key,});
static String id = 'BookDetailsScreen';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(

          children: [
            //first row
            Row(
              children: [
                const SizedBox(width: 20,),
                Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kPrimaryColor,
                    ),
                    child: IconButton(onPressed:()
                    {
                      Navigator.pop(context);
                    } ,icon:const Icon(Icons.arrow_back_ios_new_sharp , color:Colors.white,),)),
                const SizedBox(width: 10,),
                const Text('Confirm and pay',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),

              ],

            ),
            const SizedBox(height: 30,),
            //second row
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 25,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0), // Adjust the value to control the amount of rounding
                  child: Image.asset('assets/photo/home_ver/home_ver_1.jpg',
                    width: 120, // Adjust the width to fit your layout
                    height: 100, // Adjust the height to fit your layout
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(width: 20,),
             const  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hotel Name',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10,),
                    const Row(
                      children:  [
                         Icon(Icons.location_on_outlined,color: Color(0xff00c9a9),),
                         Text('Cairo, Egypt')
                      ],
                    ),
                    const SizedBox(height: 10,),
                   const Row(
                      children: [
                         Icon(Icons.star,color: Colors.amber,),
                         Text('4.4')
                      ],
                    )
                  ],
                ),

              ],
            ),
            const SizedBox(height: 30,),
            //third row trip info
          const Row(
              children: [
                 SizedBox(width: 25,),
                 Text('Your Trip',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                 Spacer(flex: 6,),
                 Text('Change',style: TextStyle(fontSize: 14),),
                 Spacer(flex: 1,)
              ],
            ),
            const SizedBox(height: 30,),
            //package row
            Row(
              children: [
                const SizedBox(width: 25,),
                Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: kPrimaryColor,width: 1),
                        borderRadius: BorderRadius.circular(15)

                    ),
                    child:  const Icon(Icons.work,color: kPrimaryColor,size: 30,)
                ),
                const SizedBox(width: 10,),
                const Text('Package \nHalawa Travel')
              ],
            ),
            const SizedBox(height: 15,),
            //Transport row
            Row(
              children: [
                const SizedBox(width: 25,),
                Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color:kPrimaryColor,width: 1),
                        borderRadius: BorderRadius.circular(15)

                    ),
                    child:  const Icon(Icons.directions_transit,color:kPrimaryColor,size: 30,)
                ),
                const SizedBox(width: 10,),
                const Text('Transport\nJolly Scania AA Bus')
              ],
            ),
            const SizedBox(height: 15,),
            //Date row
            Row(
              children: [
                const SizedBox(width: 25,),
                Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: kPrimaryColor,width: 1),
                        borderRadius: BorderRadius.circular(15)

                    ),
                    child: const Icon(Icons.calendar_today,color: kPrimaryColor,size: 30,)
                ),
                const SizedBox(width: 10,),
                const Text('Date\n22 Oct-25 Oct')
              ],
            ),
            const SizedBox(height: 20),
            //Price details row
          const   Row(
              children: [
                 SizedBox(width:25),
                 Text('Price Details',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),


              ],
            ),
            const SizedBox(height: 20),
           const  Row(
              children: [
                 SizedBox(width: 25,),
                 Text('Regular Price'),
                 Spacer(),
                 Text('\$244'),
                 SizedBox(width: 25,)
              ],
            ),
            const SizedBox(height: 20),
           const Row(
              children: [
                 SizedBox(width: 25,),
                 Text('Transports'),
                 Spacer(),
                 Text('\$55'),
                 SizedBox(width: 25,)
              ],
            ),
            const SizedBox(height: 25),
           const  Row(
              children: [
                 SizedBox(width: 25,),
                 Text('Grand Total',style: TextStyle(fontSize: 20),),
                 Spacer(),
                 Text('\339',style: TextStyle(fontSize: 20)),
                 SizedBox(width: 25,)
              ],
            ),
            const SizedBox(height: 50,),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Success booking"),
                      content: const Text("Your booking has been successful!"),
                      actions: [
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child:  Text('Book',
                style:  TextStyle(fontSize: 20, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
            ),




          ],
        ),
      ),

    );
  }
}

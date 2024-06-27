import 'package:egyvoyage/Authentication/data/shared-preferences-service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Constant/constant.dart';
import '../helpers/asset_helper.dart';
import '../helpers/image_helper.dart';
import '../widgets/app_bar_container.dart';
import 'hotel_booking_screen.dart';
import 'package:http/http.dart' as http;
class HomeScreenBooking extends StatefulWidget {
   HomeScreenBooking({Key? key}) : super(key: key);

  @override
  State<HomeScreenBooking> createState() => _HomeScreenBookingState();
}

class _HomeScreenBookingState extends State<HomeScreenBooking> {
  final List<Map<String, String>> listImageLeft = [
    {"name": 'Alexandria', 'image': AssetHelper.home_Alexandria},
    {"name": 'Dahab', 'image': AssetHelper.home_Dahab},
    {"name": 'Aswan', 'image': AssetHelper.home_Aswan},
    {"name": 'Sharm El-Shaikh', 'image': AssetHelper.home_Sharm_El_Shaikh},
  ];

  final List<Map<String, String>> listImageRight = [
    {'name': 'Luxor', 'image': AssetHelper.home_Luxor},
    {'name': 'Matruh', 'image': AssetHelper.home_Matruh},
    {'name': 'Cairo', 'image': AssetHelper.home_Cairo},
    {'name': 'Giza', 'image': AssetHelper.home_Giza},

  ];

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
  String imageUrl = '';
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
  Widget _buildItemDestination(BuildContext context, String name, String image) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HotelBookingScreen(namedDestination: name,),
            settings: RouteSettings(arguments: name)));
      },
      child: Container(
        margin:const  EdgeInsets.only(bottom: kMediumPadding),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            ImageHelper.loadFromAsset(image,
              fit: BoxFit.fitWidth,
              width: double.infinity,
              radius: const BorderRadius.all(
                Radius.circular(kDefaultPadding),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Icon(
                FontAwesomeIcons.solidHeart,
                color: Colors.red,
              ),
            ),
            Positioned(
              left: kDefaultPadding,
              bottom: kDefaultPadding,
              child: Column(
                children: [
                  Text(
                    name,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: kItemPadding),
                  Container(
                    padding: const EdgeInsets.all(kMinPadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kMinPadding),
                      color: Colors.white.withOpacity(0.4),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.solidStar,
                          color: Colors.amber,
                          size: kDefaultPadding,
                        ),
                        SizedBox(width: kItemPadding),
                        Text('4.5'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return AppBarContainer(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,),
        child: Row(
          children: [
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HI!${userData['fName']!}',
                  style:const  TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 24),
                const Text(
                  'where are you going next?',
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
           const  Spacer(),
          const   Icon(
              FontAwesomeIcons.bell,
              color: Colors.white,
              size: 18,
            ),
          const  SizedBox(width: 24),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              padding:const EdgeInsets.all(8),
              child:  imageUrl.isNotEmpty
                  ? Image.network(
                imageUrl,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.person, size: 50);
                },
              )
                  : const Icon(Icons.person, size: 50),
            ),
          ],
        ),
      ),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Search your destination',
              hintStyle: TextStyle(color: kPrimaryColor),
              prefixIcon: Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: kPrimaryColor,
                  size: 16,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
            onSubmitted: (String value){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HotelBookingScreen(namedDestination: value,),
                  settings: RouteSettings(arguments: value)));
            },
          ),
          const  SizedBox(height: 16),
          const Text('Top Cities',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,fontFamily: 'Pacifico'),),
          const  SizedBox(height: kMediumPadding),
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: listImageLeft.map(
                            (e) => _buildItemDestination(
                          context,
                          e['name']!,
                          e['image']!,
                        ),
                      ).toList(),
                    ),
                  ),
                  const   SizedBox(width: kDefaultPadding),
                  Expanded(
                    child: Column(
                      children: listImageRight.map(
                            (e) => _buildItemDestination(
                          context,
                          e['name']!,
                          e['image']!,
                        ),
                      ).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],/*{
  "distination": "Marina El Alamein",
  "start": "2024-04-24",
  "end": "2024-04-24"
}*/
      ),
    );
  }
}

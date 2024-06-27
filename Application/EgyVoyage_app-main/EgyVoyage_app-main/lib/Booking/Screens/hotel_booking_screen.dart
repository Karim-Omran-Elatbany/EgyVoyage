import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import '../Constant/constant.dart';
import '../widgets/custom_buttom.dart';
import 'package:egyvoyage/Booking/Constant/globals.dart';
import 'package:egyvoyage/Booking/Screens/guest&room_booking_screen.dart';
import 'package:egyvoyage/Booking/Screens/hotels_screen.dart';
import 'package:egyvoyage/Booking/Screens/select_date_screen.dart';
import 'package:egyvoyage/Booking/widgets/app_bar_container.dart';
import 'package:egyvoyage/Booking/widgets/item_booking_widget.dart';
import 'package:egyvoyage/Booking/extensions/date_ext.dart';

class HotelBookingScreen extends StatefulWidget {
  const HotelBookingScreen({super.key, required this.namedDestination});
  static String id = 'HotelBookingScreen';
  final String? namedDestination;

  @override
  State<HotelBookingScreen> createState() => _HotelBookingScreenState();
}

class _HotelBookingScreenState extends State<HotelBookingScreen> {
  String? dateSelected;
  TextEditingController destination = TextEditingController();
  String? startdate;
  String? enddate;
  int guest = 2;
  int room = 1;
  final List<String> famousCities = [
    'Cairo',
    'Alexandria',
    'Luxor',
    'Aswan',
    'Sharm El Sheikh',
    'Hurghada',
    'Giza',
    'Dahab',
    'Marsa Alam',
    'Siwa Oasis'
  ];

  @override
  void initState() {
    super.initState();
    destination.text = widget.namedDestination ?? '';
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    startdate = formatter.format(DateTime.now());
    enddate = formatter.format(DateTime.now().add(Duration(days: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
      implementLeading: true,
      titleString: 'Hotel booking',
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 150),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Destination', style: TextStyle()),
                  TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: destination,
                      decoration: InputDecoration(
                        labelText: 'Enter your destination',
                        labelStyle: TextStyle(),
                        prefix: Icon(
                          CupertinoIcons.location_solid,
                          size: 20,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    suggestionsCallback: (pattern) {
                      return famousCities.where(
                              (city) => city.toLowerCase().contains(pattern.toLowerCase()));
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      destination.text = suggestion;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please select a destination';
                      } else if (!famousCities.contains(value)) {
                        return 'Please enter a valid city';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ItemBookingWidget(
              icon: 'assets/icon/hotel_booking_screen_date.png',
              title: 'Select your Date  ',
              description: dateSelected ??
                  '${formatDateRange(DateTime.now(), DateTime.now().add(Duration(days: 1)))}',
              onTap: () async {
                final result = await Navigator.of(context).pushNamed(SelectDateScreen.id);

                if (!(result as List<DateTime?>).any((element) => element == null)) {
                  dateSelected = '${result[0]?.getStartDate} - ${result[1]?.getEndDate}';
                }
                String temp = result.toString();
                temp = temp.substring(1, temp.length - 1);
                List<String> list = temp.split(',');
                startdate = list[0].trim().substring(0, 10);
                enddate = list[1].trim().substring(0, 10);
                print('start date :$startdate   enddate:$enddate');
                setState(() {});
              },
            ),
            const SizedBox(height: 50),
            CustomButton(
              text: 'Search',
              onPressed: () {
                if (famousCities.contains(destination.text)) {
                  globalStart = startdate!;
                  globalEnd = enddate!;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HotelsScreen(args: {
                        'distination': destination.text,
                        'start': startdate,
                        'end': enddate
                      }),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid city')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  String formatDateRange(DateTime startDate, DateTime endDate) {
    final DateFormat dayFormatter = DateFormat('d');
    final DateFormat monthFormatter = DateFormat('MMMM');
    final DateFormat yearFormatter = DateFormat('yyyy');

    String startDay = dayFormatter.format(startDate);
    String startMonth = monthFormatter.format(startDate);
    String endDay = dayFormatter.format(endDate);
    String endMonth = monthFormatter.format(endDate);
    String year = yearFormatter.format(endDate);

    return '$startDay $startMonth - $endDay $endMonth $year';
  }
}

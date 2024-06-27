import 'package:flutter/material.dart';
import '../Constant/constant.dart';
import '../helpers/asset_helper.dart';

class ItemUtilityHotelWidget extends StatelessWidget {
  ItemUtilityHotelWidget({
    super.key,
    required this.freeWifi,
    required this.noSmoking,
    required this.freeBreakfast,
  });

  final bool freeWifi;
  final bool noSmoking;
  final bool freeBreakfast;

  // List of all utilities with their corresponding boolean properties
  final List<Map<String, dynamic>> listUtility = [
    {
      'icon': AssetHelper.iconfreewifi,
      'name': 'Free\nWifi',
      'enabled': true, // Placeholder, will be replaced
    },
    {
      'icon': AssetHelper.iconbreakfast,
      'name': 'Free\nBreakfast',
      'enabled': true, // Placeholder, will be replaced
    },
    {
      'icon': AssetHelper.iconnosmoking,
      'name': 'Non\nSmoking',
      'enabled': true, // Placeholder, will be replaced
    }
  ];

  Widget _buildItemUtilityHotel(String icon, String title) {
    return Column(
      children: [
        Image(
          image: AssetImage(icon),
          height: 32,
          width: 32,
        ),
        const SizedBox(
          height: kTopPadding,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Update the enabled status based on the boolean properties
    listUtility[0]['enabled'] = freeWifi;
    listUtility[1]['enabled'] = freeBreakfast;
    listUtility[2]['enabled'] = !noSmoking;

    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: listUtility
            .where((e) => e['enabled']) // Filter based on enabled status
            .map((e) => _buildItemUtilityHotel(e['icon']!, e['name']!))
            .toList(),
      ),
    );
  }
}
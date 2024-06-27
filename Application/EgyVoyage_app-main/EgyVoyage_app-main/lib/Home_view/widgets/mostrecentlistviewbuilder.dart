import 'package:dio/dio.dart';
import 'package:egyvoyage/Home_view/widgets/mostrecentplaceslistview.dart';
import 'package:flutter/material.dart';

import '../../Services/getplaces.dart';
import '../../Services/models/placesmodel.dart';

class MostRecentListViewbulider extends StatefulWidget {
  const MostRecentListViewbulider({
    super.key,
  });

  @override
  State<MostRecentListViewbulider> createState() => _MostRecentListViewbuliderState();
}

class _MostRecentListViewbuliderState extends State<MostRecentListViewbulider> {
  var future;

  @override
  void initState() {
    future = Placesservices(Dio()).getPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PlaceseModel>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MostRecentListview(places: snapshot.data ?? []);
          } else if (snapshot.hasError) {
            return Center(child: Text("Oops theres something wrong"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
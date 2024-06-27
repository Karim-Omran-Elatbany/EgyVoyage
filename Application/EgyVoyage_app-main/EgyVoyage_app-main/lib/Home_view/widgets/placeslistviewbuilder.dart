import 'package:dio/dio.dart';
import 'package:egyvoyage/Home_view/widgets/placeslistview.dart';
import 'package:egyvoyage/Services/getplaces.dart';
import 'package:egyvoyage/Services/models/placesmodel.dart';
import 'package:flutter/material.dart';

class placeslistviewbuilder extends StatefulWidget {
  const placeslistviewbuilder({
    super.key,
  });

  @override
  State<placeslistviewbuilder> createState() => _placeslistviewbuilderState();
}

class _placeslistviewbuilderState extends State<placeslistviewbuilder> {
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
            return PlacesListView(places: snapshot.data ?? []);
          } else if (snapshot.hasError) {
            return Center(child: Text("Oops theres something wrong"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

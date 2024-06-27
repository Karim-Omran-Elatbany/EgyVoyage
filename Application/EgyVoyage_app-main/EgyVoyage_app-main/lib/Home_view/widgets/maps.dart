import 'dart:collection';
import 'dart:convert';
import 'package:egyvoyage/Services/models/placesmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacesMaps extends StatefulWidget {
  PlacesMaps(this.lat, this.lon);

  double lat;
  double lon;

  @override
  State<PlacesMaps> createState() => _PlacesMapsState();
}

class _PlacesMapsState extends State<PlacesMaps> {
  var mymarkers = HashSet<Marker>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      height: 220,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.lat,
            widget.lon
          ),
          zoom: 10,
        ),
        onMapCreated: (googleMapController) {
          setState(() {
            /*List<String>parts=widget.placeseModel.cordinate!.split(",");
                  double latitude=double.parse(parts[0]);
                  double longitude=double.parse(parts[0]);
                  print(latitude);
                  print(longitude);*/
            mymarkers.add(Marker(
                markerId: MarkerId('1'),
                position: LatLng(widget.lat, widget.lon),
                infoWindow: InfoWindow(
                    // title: widget.placeseModel.name,
                    // snippet: widget.placeseModel.description,
                    onTap: () {})));
          });
        },
        markers: mymarkers,
      ),
    );
  }
}

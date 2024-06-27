import 'dart:math' show asin, cos, pi, pow, sin, sqrt;

import 'room_model.dart';

class HotelModel {
  HotelModel({
    required this.id,
    required this.image,
    required this.name,
    required this.location,
    required this.coordinates,
    required this.rating,
    required this.price,
    required this.description,
    required this.rooms,
  });
  final int id;
  final String image;
  final String name;
  final String location;
  final String coordinates;
  final String description;
  final double rating;
  final int price;
  final List<Room> rooms;

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id'],
      image: json['image'] ?? 'https://drive.google.com/uc?export=view&id=16miXhSQJQxh7R2umm367FMNX_K-QdmB8',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      coordinates: json['cordinate'] ?? '',
      description: json['description'] ?? 'No information found',
      rating: json['rating'] != null ? double.parse(json['rating'].toString()): 0.0,
      price: json['minprice'] != null ? (double.parse(json['minprice'].toString())).round() : 0,
      rooms: json['rooms'] != null 
          ? List<Room>.from(json['rooms'].map((roomJson) => Room.fromJson(roomJson))) 
          : [],
    );
  }

  String getFormattedRating() {
    return rating.toStringAsFixed(1); // Show one digit after the decimal point
  }
}

double calculateDistanceFromCoordinates(String coordinates, double currentLat,double currentLong ) {
  print('coordinates:$coordinates');
  if (coordinates.isEmpty) {
    return 0.0; // Return 0 if coordinates string is empty
  }
  print("ob.lat=${currentLat},ob.long=${currentLong}");
  List<String> parts = coordinates.split(','); // Split the string by comma
  double destinationLat = double.parse(parts[0].trim()); // Parse latitude
  double destinationLon = double.parse(parts[1].trim()); // Parse longitude
  // Use the calculateDistance function from the previous example
  return calculateDistance(currentLat, currentLong, destinationLat, destinationLon);
}

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const r = 6372.8; // Earth radius in kilometers

  final dLat = _toRadians(lat2 - lat1);
  final dLon = _toRadians(lon2 - lon1);
  final lat1Radians = _toRadians(lat1);
  final lat2Radians = _toRadians(lat2);

  final a = _haversin(dLat) + cos(lat1Radians) * cos(lat2Radians) * _haversin(dLon);
  final c = 2 * asin(sqrt(a));
  print(">>dist=${r*c}");
  return r * c;
}
double _toRadians(double degrees) => degrees * pi / 180;

num _haversin(double radians) => pow(sin(radians / 2), 2);


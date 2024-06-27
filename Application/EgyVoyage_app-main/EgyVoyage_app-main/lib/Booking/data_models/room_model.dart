
class Room {
  Room({
    required this.id,
    required this.roomNumber,
    required this.capacity,
    required this.breakfast,
    required this.freeWifi,
    required this.smoking,
    required this.price,
    required this.category,
    required this.image,
  });

  final int id;
  final String roomNumber;
  final int capacity;
  final bool breakfast;
  final bool freeWifi;
  final bool smoking;
  final int price;
  final String category;
  final String image;

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      roomNumber: json['roomNumber'],
      capacity: json['capacity'],
      breakfast: json['breakfast'],
      freeWifi: json['freeWifi'],
      smoking: json['smoking'],
      price: json['price'],
      category: json['category'],
      image: json['image'],
    );
  }
}

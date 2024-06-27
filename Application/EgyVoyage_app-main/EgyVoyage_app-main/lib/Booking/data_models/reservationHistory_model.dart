class ReservationHistoryModel {
  final String image;
  final String hotelName;
  final String name;
  final int totalPrice;
  final String start;
  final String end;
  final String processNumber;
  final String pinCode;
  final int id;
  final String hotelId;

  ReservationHistoryModel({
    required this.image,
    required this.hotelName,
    required this.name,
    required this.totalPrice,
    required this.start,
    required this.end,
    required this.processNumber,
    required this.pinCode,
    required this.id,
    required this.hotelId
  });

  factory ReservationHistoryModel.fromJson(Map<String, dynamic> json) {
    return ReservationHistoryModel(
      image: json['image']??'https://drive.google.com/uc?export=view&id=16miXhSQJQxh7R2umm367FMNX_K-QdmB8',
      hotelName: json['hotel_name']??'',
      name: json['name']??'',
      totalPrice: json['total_price']?? 0,
      start: json['start'],
      end: json['end'],
      processNumber: json['processNumber'].toString(),
      pinCode: json['pin_code'].toString(),
      id: json['id'],
      hotelId: json['hotelId'].toString()
    );
  }
}

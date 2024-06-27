class ReviewModel {
  final String image;
  final String name;
  final double rating;
  final String description;

  ReviewModel({
    required this.image,
    required this.name,
    required this.rating,
    required this.description,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      image: json['image']??'https://drive.google.com/uc?export=view&id=13c_3TXYlt0F6A7-WA3kwv4Fgqd_zM-gZ',
      name: json['name'],
      rating: json['rating']?? 0,
      description: json['description']?? '',
    );
  }
}

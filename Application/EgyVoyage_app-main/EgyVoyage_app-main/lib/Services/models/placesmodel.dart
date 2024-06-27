class PlaceseModel {
  int? id;
  String? name;
  String? description;
  double? rating;
  String? city;
  String? url_location;
  String? cordinate;
  String? image;
  String? start;
  String? end;
  int? adultprice;
  int? childprice;
  int? tourist;

  PlaceseModel(
      {this.id,
      this.name,
      this.description,
      this.rating,
      this.city,
      this.url_location,
      this.cordinate,
      this.image,
      this.start,
      this.end,
      this.adultprice,
      this.childprice,
      this.tourist});
  factory PlaceseModel.fromJson(Map<String, dynamic> json) {
    return PlaceseModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      rating: (json['rating'] as num?)?.toDouble(),
      city: json['city'],
      url_location: json['url_location'],
      cordinate: json['cordinate'],
      image: json['image'],
      start: json['start'],
      end: json['end'],
      adultprice: json['adultprice'],
      childprice: json['childprice'],
      tourist: json['tourist'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'rating': rating,
      'city': city,
      'url_location': url_location,
      'cordinate': cordinate,
      'image': image,
      'start': start,
      'end': end,
      'adultprice': adultprice,
      'childprice': childprice,
      'tourist': tourist,
    };
  }
}




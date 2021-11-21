import 'review.dart';

class Food {
  final int id;
  final String name;
  final String address;
  final String tel;
  final int reviewCount;
  final double rate;
  final String imgPath;
  final List<Review> reviews;

  const Food({
    required this.id,
    required this.name,
    required this.address,
    required this.tel,
    required this.reviewCount,
    required this.rate,
    required this.imgPath,
    required this.reviews
  });

  factory Food.fromJson(Map<String, dynamic> json, img) {

    List<Review> _reviews = [];

    json['reviews'].forEach(
        (var json) => _reviews.add(Review.fromJson(json))
    );

    return Food(
        id: json['id'],
        name: json['name'],
        address: json['address'] ??= "[주소가 등록되지 않았습니다]",
        tel: json['tel'] ??= "[전화번호가 등록되지 않았습니다]",
        reviewCount: json['reviewNum'],
        rate: json['rate'].toDouble(),
        imgPath: json['image'] ??= img,
        reviews: _reviews
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'address': address,
    'tel': tel,
    'reviewNum': reviewCount,
    'rate': rate,
    'image': imgPath,
    'reviews': reviews
  };
}

class Foods {
  final int id;
  final String name;
  final int reviewCount;
  final double rate;
  final String imgPath;

  const Foods({
    required this.id,
    required this.name,
    required this.reviewCount,
    required this.rate,
    required this.imgPath
  });

  factory Foods.fromJson(Map<String, dynamic> json, img) => Foods(
      id: json['id'],
      name: json['name'],
      reviewCount: json['reviewNum'],
      rate: json['rate'].toDouble(),
      imgPath: json['image'] ??= img
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'reviewNum': reviewCount,
    'rate': rate,
    'image': imgPath
  };
}
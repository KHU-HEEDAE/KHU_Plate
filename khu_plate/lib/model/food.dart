import 'review.dart';
import 'dart:math';

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

  factory Food.fromJson(Map<String, dynamic> json) {
    List<Review> _reviews = [];

    json['reviews'].forEach(
        (var json) => _reviews.add(Review.fromJson(json))
    );

    Random random = Random();
    int ranNum = random.nextInt(5);

    var img = '';

    switch(ranNum) {
      case 0:
        img = "assets/banner_images/food1.png";
        break;
      case 1:
        img = "assets/banner_images/food2.png";
        break;
      case 2:
        img = "assets/banner_images/food3.png";
        break;
      case 3:
        img = "assets/banner_images/food4.png";
        break;
      case 4:
        img = "assets/banner_images/food5.png";
        break;
    }

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

  factory Foods.fromJson(Map<String, dynamic> json) {
    Random random = Random();
    int ranNum = random.nextInt(5);

    var img = '';

    switch(ranNum) {
      case 0:
        img = "assets/banner_images/food1.png";
        break;
      case 1:
        img = "assets/banner_images/food2.png";
        break;
      case 2:
        img = "assets/banner_images/food3.png";
        break;
      case 3:
        img = "assets/banner_images/food4.png";
        break;
      case 4:
        img = "assets/banner_images/food5.png";
        break;
    }

    return Foods(
        id: json['id'],
        name: json['name'],
        reviewCount: json['reviewNum'],
        rate: json['rate'].toDouble(),
        imgPath: json['image'] ??= img
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'reviewNum': reviewCount,
    'rate': rate,
    'image': imgPath
  };
}
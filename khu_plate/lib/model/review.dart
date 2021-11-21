import 'package:flutter/cupertino.dart';
import 'dart:math';

class Review {
  final int id;
  final int foodId;
  final String username;
  final double rate;
  final String content;
  final String imgPath;
  final String avatarPath;

  const Review({
    required this.id,
    required this.foodId,
    required this.username,
    required this.rate,
    required this.content,
    required this.imgPath,
    required this.avatarPath
  });

  factory Review.fromJson(Map<String, dynamic> json) {
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

    return Review(
        id: json['id'],
        foodId: json['foodId'],
        username: json['reviewer'],
        rate: json['rate'].toDouble(),
        content: json['content'] ??= "",
        imgPath: json['image'] ??= img,
        avatarPath: json['avatar_path'] ??= "assets/icons/avatar_icon.png"
    );
  }
}

class ReviewPost {
  final int foodId;
  final String reviewer;
  final double rate;
  final String? content;

  const ReviewPost({
    required this.foodId,
    required this.reviewer,
    required this.rate,
    this.content
  });

  Map<String, dynamic> toJson() => {
    'foodId': foodId,
    'reviewer': reviewer,
    'rate': rate,
    'content': content,
  };
}
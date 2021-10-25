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

  factory Review.fromJson(Map<String, dynamic> json) => Review(
      id: json['id'],
      foodId: json['food_id'],
      username: json['writer'],
      rate: json['rate'].toDouble(),
      content: json['content'] ??= "",
      imgPath: json['image'] ??= "",
      avatarPath: json['avatar_path'] ??= "assets/icons/avatar_icon.png"
  );
}

class ReviewPost {
  final int foodId;
  final int userId;
  final double rate;
  final String? content;
  final String? imgPath;

  const ReviewPost({
    required this.foodId,
    required this.userId,
    required this.rate,
    this.content,
    this.imgPath,
  });

  Map<String, dynamic> toJson() => {
    'food_id': foodId,
    'user_id': userId,
    'rate': rate,
    'content': content,
    'image': imgPath
  };
}
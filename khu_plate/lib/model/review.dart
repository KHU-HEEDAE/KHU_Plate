class Review {
  final int id;
  final String username;
  final double rate;
  final String content;
  final String imgPath;
  final String avatarPath;

  const Review({
    required this.id,
    required this.username,
    required this.rate,
    required this.content,
    required this.imgPath,
    required this.avatarPath
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
      id: json['id'],
      username: json['username'],
      rate: json['rate'].toDouble(),
      content: json['content'] ??= "",
      imgPath: json['img_path'] ??= "",
      avatarPath: json['avatar_path'] ??= "assets/icons/avatar_icon.png"
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'rate': rate,
    'content': content,
    'img_path': imgPath,
    'avatar_path': avatarPath
  };
}
class Food {
  final int id;
  final String name;
  final String address;
  final String tel;
  final int reviewCount;
  final double rate;
  final String imgPath;

  const Food({
    required this.id,
    required this.name,
    required this.address,
    required this.tel,
    required this.reviewCount,
    required this.rate,
    required this.imgPath
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
    id: json['id'],
    name: json['name'],
    address: json['address'] ??= "[주소가 등록되지 않았습니다]",
    tel: json['tel'] ??= "[전화번호가 등록되지 않았습니다]",
    reviewCount: json['review_count'],
    rate: json['rate'].toDouble(),
    imgPath: json['img_path'] ??= "assets/banner_images/default.png"
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'address': address,
    'tel': tel,
    'review_count': reviewCount,
    'rate': rate,
    'img_path': imgPath
  };
}
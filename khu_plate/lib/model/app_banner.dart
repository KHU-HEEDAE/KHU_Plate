class AppBanner {
  final int id;
  final String imgPath;
  final String txt1;
  final String txt2;

  const AppBanner({
    required this.id,
    required this.imgPath,
    required this.txt1,
    required this.txt2
  });

  factory AppBanner.fromJson(Map<String, dynamic> json) => AppBanner(
      id: json['id'],
      imgPath: json['image'] ??= "assets/banner_images/default.png",
      txt1: json['txt1'] ??= '',
      txt2: json['txt2'] ??= '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'img_path': imgPath,
    'txt1': txt1,
    'txt2': txt2
  };
}
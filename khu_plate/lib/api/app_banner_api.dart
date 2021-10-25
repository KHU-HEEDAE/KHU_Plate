import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/app_banner.dart';

class BannerApi {
  static Future<List<AppBanner>> getBanners() async {
    final url = Uri.parse('http://10.0.2.2:8080/api/banner');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final List banners = json.decode(res.body);

      return banners.map((json) => AppBanner.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }
}
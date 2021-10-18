import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/review.dart';

class ReviewApi {
  static Future<List<Review>> getReviews(int id) async {
    final url = Uri.parse('http://10.0.2.2:8080/api/review/$id');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final List reviews = json.decode(res.body);

      return reviews.map((json) => Review.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }
}
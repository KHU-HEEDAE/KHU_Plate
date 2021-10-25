import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/review.dart';

class ReviewApi {
  static Future<List<Review>> getReviews() async {
    final url = Uri.parse('http://10.0.2.2:8080/api/review');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final List reviews = json.decode(res.body);

      return reviews.map((json) => Review.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }

  static Future<void> postReview(ReviewPost review) async {
    print(jsonEncode(review.toJson()));
    final url = Uri.parse('http://10.0.2.2:8080/api/review');
    final res = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(review.toJson()));

    if (res.statusCode == 200) {
      print(res.statusCode);
    } else {
      throw Exception('error');
    }
  }
}
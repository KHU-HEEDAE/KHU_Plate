import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/food.dart';

class FoodApi {
  static Future<List<Food>> getFoods(String query) async {
    final url = Uri.parse('http://10.0.2.2:8080/api/food');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final List foods = json.decode(res.body);

      if (query != '') {
        return foods.map((json) => Food.fromJson(json)).where((food) {
          final name = food.name.replaceAll(' ', '');
          final match = query.replaceAll(' ', '');

          return name.contains(match);
        }).toList();
      } else {
        return foods.map((json) => Food.fromJson(json)).toList();
      }
    } else {
      throw Exception();
    }
  }
}
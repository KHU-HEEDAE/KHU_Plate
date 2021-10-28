import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/food.dart';

class FoodApi {
  static Future<List<Foods>> getFoods(String query) async {
    final url = Uri.parse('http://10.0.2.2:8080/api/food');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final List foods = json.decode(res.body);

      if (query != '') {
        return foods.map((json) => Foods.fromJson(json)).where((food) {
          final name = food.name.replaceAll(' ', '');
          final match = query.replaceAll(' ', '');

          return name.contains(match);
        }).toList();
      } else {
        return foods.map((json) => Foods.fromJson(json)).toList();
      }
    } else {
      throw Exception();
    }
  }

  static Future<Food> getFood(String query) async {
    final url = Uri.parse('http://10.0.2.2:8080/api/food/$query');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final food = json.decode(res.body);

      return Food.fromJson(food);
    } else {
      throw Exception();
    }
  }
  
  static Future<List<Foods>> getCategory(int categoryId, int priorityId) async {
    final url = Uri.parse('http://10.0.2.2:8080/api/food/category/${categoryId.toString()}/${priorityId.toString()}');
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final List foods = json.decode(res.body);

      return foods.map((json) => Foods.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }
}
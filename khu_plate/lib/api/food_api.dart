import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/food.dart';
import 'dart:math';

Random random = Random();
int ranNum = random.nextInt(5);

class FoodApi {
  static Future<List<Foods>> getFoods(String query) async {
    final url = Uri.parse('http://10.0.2.2:8080/api/food');
    final res = await http.get(url);

    final List foods = jsonDecode(utf8.decode(res.bodyBytes));
    print(foods);
    if (query != '') {
      return foods.map((json) => Foods.fromJson(json)).where((food) {
        final name = food.name.replaceAll(' ', '');
        final match = query.replaceAll(' ', '');
        return name.contains(match);
      }).toList();
    } else {
      return foods.map((json) => Foods.fromJson(json)).toList();
    }
  }

  static Future<Food> getFood(String query) async {
    final url = Uri.parse('http://10.0.2.2:8080/api/food/$query');
    final res = await http.get(url);


      final food = jsonDecode(utf8.decode(res.bodyBytes));

      return Food.fromJson(food);
  }
  
  static Future<List<Foods>> getCategory(int categoryId, int priorityId) async {
    final url = Uri.parse('http://10.0.2.2:8080/api/food/category/${categoryId.toString()}/${priorityId.toString()}');
    final res = await http.get(url);



      final List foods = jsonDecode(utf8.decode(res.bodyBytes));

      return foods.map((json) => Foods.fromJson(json)).toList();
  }
}
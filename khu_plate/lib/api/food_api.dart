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
    
    jsonDecode(utf8.decode(res.bodyBytes));
    
    var img = '';

    switch(ranNum) {
      case 0:
        img = "assets/banner_images/food1.png";
        break;
      case 1:
        img = "assets/banner_images/food2.png";
        break;
      case 2:
        img = "assets/banner_images/food3.png";
        break;
      case 3:
        img = "assets/banner_images/food4.png";
        break;
      case 4:
        img = "assets/banner_images/food5.png";
        break;
    }

      final List foods = json.decode(res.body);

      if (query != '') {
        return foods.map((json) => Foods.fromJson(json, img)).where((food) {
          final name = food.name.replaceAll(' ', '');
          final match = query.replaceAll(' ', '');

          return name.contains(match);
        }).toList();
      } else {
        return foods.map((json) => Foods.fromJson(json, img)).toList();
      }
  }

  static Future<Food> getFood(String query) async {
    final url = Uri.parse('http://10.0.2.2:8080/api/food/$query');
    final res = await http.get(url);

    jsonDecode(utf8.decode(res.bodyBytes));

    var img = '';

    switch(ranNum) {
      case 0:
        img = "assets/banner_images/food1.png";
        break;
      case 1:
        img = "assets/banner_images/food2.png";
        break;
      case 2:
        img = "assets/banner_images/food3.png";
        break;
      case 3:
        img = "assets/banner_images/food4.png";
        break;
      case 4:
        img = "assets/banner_images/food5.png";
        break;
    }

      final food = json.decode(res.body);

      return Food.fromJson(food, img);
  }
  
  static Future<List<Foods>> getCategory(int categoryId, int priorityId) async {
    final url = Uri.parse('http://10.0.2.2:8080/api/food/category/${categoryId.toString()}/${priorityId.toString()}');
    final res = await http.get(url);

    jsonDecode(utf8.decode(res.bodyBytes));

    var img = '';

    switch(ranNum) {
      case 0:
        img = "assets/banner_images/food1.png";
        break;
      case 1:
        img = "assets/banner_images/food2.png";
        break;
      case 2:
        img = "assets/banner_images/food3.png";
        break;
      case 3:
        img = "assets/banner_images/food4.png";
        break;
      case 4:
        img = "assets/banner_images/food5.png";
        break;
    }

      final List foods = json.decode(res.body);

      return foods.map((json) => Foods.fromJson(json, img)).toList();
  }
}
import 'package:flutter/material.dart';
import 'package:khu_plate/model/food.dart';
import 'package:khu_plate/navigation.dart';
import 'package:khu_plate/screens/res_info.dart';
import 'package:khu_plate/screens/write_review_popup.dart';
import 'res_info_screen_arguments.dart';
import 'write_review_screen_arguments.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Nav());
      case '/res-info':
        if (settings.arguments is Object) {
          final args = settings.arguments as ResInfoScreenArguments;

          return MaterialPageRoute(
              builder: (_) => ResInfo(
                id: args.id
              )
          );
        }
        return _errRoute();
      case '/write-review':
        if (settings.arguments is Object) {
          final args = settings.arguments as WriteReviewScreenArguments;

          Foods food = Foods(
              id: args.id,
              name: args.name,
              reviewCount: args.reviewCount,
              rate: args.rate,
              imgPath: args.imgPath
          );

          return MaterialPageRoute(
              builder: (_) => WriteReviewPopup(
                food: food
              )
          );
        }
        return _errRoute();
      default:
        return _errRoute();
    }
  }

  static Route<dynamic> _errRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('404 error')
        )
      );
    });
  }
}
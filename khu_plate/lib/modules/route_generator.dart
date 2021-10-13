import 'package:flutter/material.dart';
import 'package:khu_plate/navigation.dart';
import 'package:khu_plate/screens/res_info.dart';
import 'res_info_screen_arguments.dart';

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
                img: args.img,
                name: args.name,
                rate: args.rate,
                numReview: args.numReview
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
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '홈',
        style: TextStyle(fontWeight: FontWeight.bold),
      )
    );
  }
}
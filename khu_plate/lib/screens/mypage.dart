import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
          '더보기',
          style: TextStyle(fontWeight: FontWeight.w300),
        )
    );
  }
}
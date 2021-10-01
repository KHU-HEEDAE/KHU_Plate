import 'package:flutter/material.dart';

class ReviewFeed extends StatelessWidget {
  const ReviewFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
          '최신리뷰',
          style: TextStyle(fontWeight: FontWeight.w500),
        )
    );
  }
}
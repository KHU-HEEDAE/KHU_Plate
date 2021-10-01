import 'package:flutter/material.dart';

class WriteReview extends StatelessWidget {
  const WriteReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
          '리뷰작성',
          style: TextStyle(fontWeight: FontWeight.w400),
        )
    );
  }
}
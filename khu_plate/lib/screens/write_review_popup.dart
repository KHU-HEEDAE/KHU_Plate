import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../model/food.dart';
import 'write_review.dart';

class WriteReviewPopup extends StatefulWidget {
  const WriteReviewPopup({Key? key, required this.food}) : super(key: key);

  final Food food;

  @override
  _WriteReviewPopupState createState() => _WriteReviewPopupState();
}

class _WriteReviewPopupState extends State<WriteReviewPopup> {
  @override
  void initState () {
    _food = widget.food;
    super.initState();
  }

  late Food _food;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 25,
                          padding: const EdgeInsets.only(left: 20),
                          child: SizedBox(
                            width: 50,
                            height: 25,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero
                                ),
                                child: Row(
                                    children: [
                                      SizedBox(
                                          width: 6,
                                          height: 16,
                                          child: SvgPicture.asset(
                                            "assets/icons/left_arrow_icon.svg",
                                            color: Colors.black,
                                          )
                                      ),
                                      const SizedBox(width: 6),
                                      const Text('뒤로',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black
                                          )
                                      )
                                    ]
                                )
                            )
                          )
                        ),
                        WriteReview(food: _food)
                      ]
                  )
              )
          )
      )
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khu_plate/api/review_api.dart';
import 'package:khu_plate/model/review.dart';

class ReviewList extends StatefulWidget {
  const ReviewList({Key? key}) : super(key: key);

  @override
  _ReviewListState createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  Future<void> _getReviews() async {
    final reviews = await ReviewApi.getReviews();
    setState(() {
      _reviews = reviews;
    });
  }

  List<Review> _reviews = [];

  @override
  void initState() {
    super.initState();
    _getReviews();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      padding: const EdgeInsets.all(20),
      itemCount: _reviews.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      offset: Offset(0.0, 1.0),
                      blurRadius: 4.0,
                      spreadRadius: 0.0
                  )
                ]
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(0.0),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.5),
                                      offset: Offset(0.0, 2.0),
                                      blurRadius: 4.0,
                                      spreadRadius: 0.0
                                  )
                                ]
                            ),
                            child: CircleAvatar(
                                radius: 15,
                                backgroundImage: AssetImage(_reviews[index].avatarPath)
                            )
                        ),
                        const SizedBox(width: 10),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  _reviews[index].username,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500
                                  )
                              ),
                              const SizedBox(height: 4),
                              Row(
                                  children: [
                                    SizedBox(
                                        width: 10,
                                        height: 10,
                                        child: SvgPicture.asset("assets/icons/star_filled_icon.svg")
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                        _reviews[index].rate.toStringAsFixed(1),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF898989)
                                        )
                                    )
                                  ]
                              )
                            ]
                        )
                      ]
                  ),
                  const SizedBox(height: 10),
                  if (_reviews[index].content != '')
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                  _reviews[index].content,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12)
                              )
                          )
                        )
                      ]
                    ),
                  if (_reviews[index].imgPath != '')
                    Container(
                        width: 300,
                        height: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                image: AssetImage(_reviews[index].imgPath),
                                fit: BoxFit.cover)
                        )
                    )
                ]
            )
        );
      }
    );
  }
}
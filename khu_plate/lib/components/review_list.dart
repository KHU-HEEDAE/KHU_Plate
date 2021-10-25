import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khu_plate/api/review_api.dart';
import 'package:khu_plate/components/image_modal.dart';
import 'package:khu_plate/model/review.dart';
import 'package:khu_plate/modules/res_info_screen_arguments.dart';

class ReviewList extends StatefulWidget {
  const ReviewList({Key? key}) : super(key: key);

  @override
  _ReviewListState createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  Future<void> _getReviews() async {
    final reviews = await ReviewApi.getReviews();
    setState(() {
      _reviews = reviews.where((review) => review.imgPath != '' || review.content != '').toList();
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
      padding: const EdgeInsets.only(top: 20),
      itemCount: _reviews.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(
                color: Color(0xFFF8F8F8)
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
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
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500
                                    )
                                ),
                                const SizedBox(height: 2),
                                Row(
                                    children: [
                                      if (_reviews[index].rate.toStringAsFixed(1).split('.')[1] != '0')
                                        for (int i = 0; i < 5; i++)
                                          if (i < _reviews[index].rate.toInt())
                                            SizedBox(
                                                width: 14,
                                                height: 14,
                                                child: SvgPicture.asset("assets/icons/star_filled_icon.svg")
                                            )
                                          else if (i == _reviews[index].rate.toInt())
                                            SizedBox(
                                                width: 14,
                                                height: 14,
                                                child: SvgPicture.asset("assets/icons/star_half_icon.svg")
                                            )
                                          else
                                            SizedBox(
                                                width: 14,
                                                height: 14,
                                                child: SvgPicture.asset("assets/icons/star_filled_icon.svg", color: const Color(0xFFDCDCDC))
                                            )
                                      else
                                        for (int i = 0; i < 5; i++)
                                          if (i < _reviews[index].rate.toInt())
                                            SizedBox(
                                                width: 14,
                                                height: 14,
                                                child: SvgPicture.asset("assets/icons/star_filled_icon.svg")
                                            )
                                          else
                                            SizedBox(
                                                width: 14,
                                                height: 14,
                                                child: SvgPicture.asset("assets/icons/star_filled_icon.svg", color: const Color(0xFFDCDCDC))
                                            ),
                                      const SizedBox(width: 5),
                                      Text(
                                          _reviews[index].rate.toStringAsFixed(1),
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF898989)
                                          )
                                      )
                                    ]
                                )
                              ]
                          ),
                          const Expanded(child: SizedBox()),
                          SizedBox(
                              width: 80,
                              height: 14,
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        '/res-info',
                                        arguments: ResInfoScreenArguments(
                                            _reviews[index].foodId
                                        )
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero
                                  ),
                                  child: Row(
                                    children: [
                                      const Text('음식점 정보',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF898989)
                                          )
                                      ),
                                      const SizedBox(width: 4),
                                      SizedBox(
                                          width: 10,
                                          height: 14,
                                          child: SvgPicture.asset(
                                            "assets/icons/right_arrow_icon.svg",
                                            color: const Color(0xFF898989),
                                          )
                                      )
                                    ],
                                  )
                              )
                          )
                        ]
                    )
                  ),
                  if (_reviews[index].content != '')
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                              padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                              child: Text(
                                  _reviews[index].content,
                                  maxLines: 100,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      height: 1.5,
                                      color: Color(0xFF898989)
                                  )
                              )
                          )
                        )
                      ]
                    ),
                  if (_reviews[index].imgPath != '')
                    GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (_) => ImageModal(page: 'list', imgPath: _reviews[index].imgPath)
                        );
                      },
                      child: Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(_reviews[index].imgPath),
                                  fit: BoxFit.cover)
                          )
                      )
                    )
                ]
            )
        );
      }
    );
  }
}
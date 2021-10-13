import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khu_plate/components/res_reviews.dart';

class ResInfo extends StatelessWidget {
  const ResInfo({Key? key, required this.img, required this.name, required this.rate, required this.numReview}) : super(key: key);

  final String img;
  final String name;
  final String rate;
  final String numReview;

  @override
  Widget build(BuildContext context) {
    bool isHalfStar;
    String tenth = rate.split('.')[1];

    tenth != '0' ? isHalfStar = true : isHalfStar = false;

    double starRate = double.parse(rate);
    int rateInt = starRate.toInt();

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
            children: [
              SizedBox(
                  height: 240,
                  child: Stack(
                      children: [
                        Container(
                            height: 240,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(img),
                                    fit: BoxFit.cover
                                )
                            )
                        ),
                        Container(
                            height: 240,
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(0, 0, 0, 0.5)
                            )
                        )
                      ]
                  )
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width),
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(top: 180, right: 5, left: 5),
                    child: Column(
                        children: [
                          Container(
                              width: 320,
                              padding: const EdgeInsets.all(20),
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
                                  children: [
                                    Text(
                                      name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 24
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          if (isHalfStar)
                                            for (int i = 0; i < 5; i++)
                                              if (i < rateInt)
                                                SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child: SvgPicture.asset("assets/icons/star_filled_icon.svg")
                                                )
                                              else if (i == rateInt)
                                                SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child: SvgPicture.asset("assets/icons/star_half_icon.svg")
                                                )
                                              else
                                                SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child: SvgPicture.asset("assets/icons/star_filled_icon.svg", color: const Color(0xFFDCDCDC))
                                                )
                                          else
                                            for (int i = 0; i < 5; i++)
                                              if (i < rateInt)
                                                SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child: SvgPicture.asset("assets/icons/star_filled_icon.svg")
                                                )
                                              else
                                                SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child: SvgPicture.asset("assets/icons/star_filled_icon.svg", color: const Color(0xFFDCDCDC))
                                                ),
                                          const SizedBox(width: 10),
                                          Text(
                                              rate,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300,
                                                  color: Color(0xFF898989)
                                              )
                                          )
                                        ]
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                        children: const [
                                          Text(
                                              "주소: 수원시 영통구 희대로",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF898989)
                                              )
                                          )
                                        ]
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                        children: const [
                                          Text(
                                              "전화번호: 000-0000-0000",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF898989)
                                              )
                                          )
                                        ]
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                        children: const [
                                          Text(
                                              "영업시간: 월 ~ 일 10 A.M. ~ 9 P.M.",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF898989)
                                              )
                                          )
                                        ]
                                    )
                                  ]
                              )
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                              width: 320,
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                        "리뷰",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500
                                        )
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                        "(" + numReview + "개의 리뷰)",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400
                                        )
                                    ),
                                    Flexible(
                                        child: Container(
                                            height: 16
                                        )
                                    ),
                                    SizedBox(
                                        width: 66,
                                        height: 18,
                                        child: TextButton(
                                            onPressed: () {},
                                            style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero
                                            ),
                                            child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  const Text('리뷰하기',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w400,
                                                          color: Color(0xFF898989)
                                                      )
                                                  ),
                                                  const SizedBox(width: 4),
                                                  SizedBox(
                                                      width: 6,
                                                      height: 16,
                                                      child: SvgPicture.asset(
                                                        "assets/icons/right_arrow_icon.svg",
                                                        color: const Color(0xFF898989),
                                                      )
                                                  )
                                                ]
                                            )
                                        )
                                    )
                                  ]
                              )
                          ),
                          const SizedBox(height: 10),
                          ResReviews(data: name)
                        ]
                    )
                )
              ),
              SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: SizedBox(
                          width: 40,
                          height: 16,
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
                                          color: Colors.white,
                                        )
                                    ),
                                    const SizedBox(width: 6),
                                    const Text('뒤로',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white
                                        )
                                    )
                                  ]
                              )
                          )
                      )
                  )
              )
            ]
        )
      )
    );
  }

}
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_svg/svg.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _currentBanner = 0;

  final List<Widget> _pageViewChildren = [];

  final PageController _pageController = PageController();

  Future<Map<String, List<String>>> _getData() async {
    await Future.delayed(const Duration(seconds: 2));

    return {
      "imgList": [
        "assets/banner_images/food1.png",
        "assets/banner_images/food2.png",
        "assets/banner_images/food3.png",
        "assets/banner_images/food4.png",
        "assets/banner_images/food5.png"
      ],
      "txtList1": [
        "당신에게 추천하는 고깃집!",
        "당신에게 추천하는 스시집!",
        "당신에게 추천하는 파스타집!",
        "당신에게 추천하는 중식집!",
        "당신에게 추천하는 백반집!"
      ],
      "txtList2": [
        "고기 맛집 보러 가기",
        "스시 맛집 보러 가기",
        "파스타 맛집 보러 가기",
        "중식 맛집 보러 가기",
        "한식 맛집 보러 가기"
      ]
    };
  }

  Future<Map<String, List<String>>>? resData;

  @override
  void initState() {
    super.initState();

    resData = _getData();

    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      _pageController.animateToPage(
        ++_currentBanner,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 240,
        child: DecoratedBox(
            decoration: const BoxDecoration(
                color: Color(0xFFD8D8D8)
            ),
            child: Stack(
                alignment: Alignment.center,
                children: [
                  FutureBuilder(
                      future: resData,
                      builder: (context, AsyncSnapshot<Map<String, List<String>>> snapshot) {
                        Widget child = const SizedBox();

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          child = const Center(
                              child: SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 5
                                  )
                              )
                          );
                        } else if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            for (var i = 0; i < snapshot.data!["imgList"]!.length; i++) {
                              _pageViewChildren.add(
                                  Container(
                                      height: 240,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(snapshot.data!["imgList"]![i]),
                                              fit: BoxFit.cover)
                                      ),
                                      child: Stack(
                                        alignment: Alignment.bottomLeft,
                                        children: [
                                          Container(
                                              height: 240,
                                              decoration: const BoxDecoration(
                                                  color: Color.fromRGBO(0, 0, 0, 0.5)
                                              )
                                          ),
                                          Positioned(
                                              bottom: 36,
                                              left: 20,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    snapshot.data!["txtList1"]![i],
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 24,
                                                        color: Colors.white
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        snapshot.data!["txtList2"]![i],
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.white
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      SizedBox(
                                                          width: 6,
                                                          height: 11,
                                                          child: SvgPicture.asset("assets/icons/right_arrow_icon.svg")
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )
                                          )
                                        ],
                                      )
                                  )
                              );
                            }

                            child = PageView.builder(
                                itemBuilder: (context, index) {
                                  return _pageViewChildren[index % _pageViewChildren.length];
                                },
                                controller: _pageController,
                                onPageChanged: (index) {
                                  setState(() {
                                    _currentBanner = index;
                                  });
                                }
                            );
                          } else if (snapshot.hasError) {
                            child = const Text('error');
                          }
                        } else {
                          child = const Text('error');
                        }

                        return child;
                      }
                  ),
                  FutureBuilder(
                      future: resData,
                      builder: (context, AsyncSnapshot<Map<String, List<String>>> snapshot) {
                        Widget child = const SizedBox();

                        if(snapshot.hasData) {
                          child = Positioned(
                              bottom: 10,
                              child: Row(
                                  children: [
                                    for (var i = 0; i < snapshot.data!["imgList"]!.length; i++)
                                      Container(
                                          padding: const EdgeInsets.only(left: 5, right: 5),
                                          child: SizedBox(
                                              height: 6,
                                              width: (_currentBanner % snapshot.data!["imgList"]!.length == i ? 25 : 6),
                                              child: (_currentBanner % snapshot.data!["imgList"]!.length == i
                                                  ? SizedBox(
                                                width: 25,
                                                height: 6,
                                                child: SvgPicture.asset("assets/icons/pagination_dash.svg"),
                                              )
                                                  : SizedBox(
                                                width: 6,
                                                height: 6,
                                                child: SvgPicture.asset("assets/icons/pagination_dot.svg"),
                                              )
                                              )
                                          )
                                      )
                                  ]
                              )
                          );
                        }

                        return child;
                      }
                  )
                ]
            )
        )
    );
  }
}

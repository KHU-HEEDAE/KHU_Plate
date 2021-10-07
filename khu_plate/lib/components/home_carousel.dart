import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_svg/svg.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {

  var imgList = ["assets/banner_images/food1.png", "assets/banner_images/food2.png", "assets/banner_images/food3.png"];
  var textList1 = ["당신에게 추천하는 고깃집!", "당신에게 추천하는 생선집!", "당신에게 추천하는 파스타집!"];
  var textList2 = ["고기 맛집 보러 가기", "생선 맛집 보러 가기", "파스타 맛집 보러 가기"];

  int _currentBanner = 0;

  final List<Widget> _pageViewChildren = [];

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < imgList.length; i++) {
      _pageViewChildren.add(
          Container(
              height: 240,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imgList[i]),
                      fit: BoxFit.cover
                  )
              ),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    height: 240,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.5)
                    ),
                  ),
                  Positioned(
                      bottom: 36,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            textList1[i],
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
                                textList2[i],
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white
                                ),
                              ),
                              const SizedBox(
                                  width: 10
                              ),
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
      child: Stack (
          alignment: Alignment.center,
          children: [
            PageView.builder(
                itemBuilder: (context, index) {
                  return _pageViewChildren[index % _pageViewChildren.length];
                },
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentBanner = index;
                  });
                }
            ),
            Positioned(
                bottom: 10,
                child: Row(
                    children: [
                      for (var i = 0; i < imgList.length; i++)
                        Container(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: SizedBox(
                                height: 6,
                                width: (_currentBanner % imgList.length == i ? 25 : 6),
                                child:
                                  (_currentBanner % imgList.length == i
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
                )
          ]
      )
    );
  }
}
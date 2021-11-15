import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_svg/svg.dart';
import '../modules/res_list_screen_arguments.dart';
// http api
import 'package:khu_plate/model/app_banner.dart';
import '../api/app_banner_api.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    resData = _getBanners();

    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      _pageController.animateToPage(
        ++_currentBanner,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  int _currentBanner = 0;

  final List<Widget> _pageViewChildren = [];

  final PageController _pageController = PageController();

  Future<List<AppBanner>> _getBanners() async {
    return await BannerApi.getBanners();
  }

  Future<List<AppBanner>>? resData;

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
                      builder: (context, AsyncSnapshot<List<AppBanner>> snapshot) {
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
                            for (var i = 0; i < snapshot.data!.length; i++) {
                              _pageViewChildren.add(
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          '/res-list',
                                          arguments: ResListScreenArguments(
                                              snapshot.data![i].categoryId,
                                              0,
                                              null
                                          )
                                      );
                                    },
                                    child: Container(
                                        height: 240,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(snapshot.data![i].imgPath),
                                                fit: BoxFit.cover
                                            )
                                        ),
                                        child: Stack(
                                          alignment: Alignment.bottomLeft,
                                          children: [
                                            Container(
                                                height: 240,
                                                decoration: const BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin: Alignment.bottomCenter,
                                                        end: Alignment.topCenter,
                                                        colors: [
                                                          Color.fromRGBO(0, 0, 0, 0.6),
                                                          Colors.transparent
                                                        ],
                                                        stops: [
                                                          0.3,
                                                          1.0
                                                        ]
                                                    )
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
                                                      snapshot.data![i].txt1,
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
                                                          snapshot.data![i].txt2,
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
                            child = SizedBox(
                              height: 240,
                              width: MediaQuery.of(context).size.width,
                              child: const Center(
                                child: Text(
                                    'Connection Error\n연결 오류',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14
                                  )
                                )
                              )
                            );
                          }
                        } else {
                          child = const Text('error');
                        }

                        return child;
                      }
                  ),
                  FutureBuilder(
                      future: resData,
                      builder: (context, AsyncSnapshot<List<AppBanner>> snapshot) {
                        Widget child = const SizedBox();

                        if(snapshot.hasData) {
                          child = Positioned(
                              bottom: 10,
                              child: Row(
                                  children: [
                                    for (var i = 0; i < snapshot.data!.length; i++)
                                      Container(
                                          padding: const EdgeInsets.only(left: 5, right: 5),
                                          child: SizedBox(
                                              height: 6,
                                              width: (_currentBanner % snapshot.data!.length == i ? 25 : 6),
                                              child: (_currentBanner % snapshot.data!.length == i
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

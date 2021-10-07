import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../components/home_carousel.dart';
import '../components/search_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _thumbWheels = ["카테고리", "기준"];
  final _categoryList = ["아무거나", "한식", "일식", "중식", "양식"];
  final _orderList = ["최신순", "평점순", "리뷰순"];

  int _curCategoryIdx = 0;
  int _curOrderIdx = 0;

  final PageController _categoryController = PageController(
    keepPage: true,
    viewportFraction: 0.3
  );

  final PageController _orderController = PageController(
      keepPage: true,
      viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Stack (
            children: const [
              Carousel(),
              SearchBar()
            ]
          ),
          Center(
            child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    // 카테고리 선택 및 기준 선택
                    for (var i = 0; i < _thumbWheels.length; i++)
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                  _thumbWheels[i] + " 선택",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12
                                  )
                              )
                            )
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                              width: 80,
                              height: 7,
                              child: SvgPicture.asset("assets/icons/thumb_wheel_deco_icon.svg")
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 25,
                            child: Stack(
                              children: [
                                i == 0
                                ? PageView.builder(
                                    controller: _categoryController,
                                    itemCount: _categoryList.length,
                                    itemBuilder: (context, index) {
                                      return Center(
                                        child:
                                          (_curCategoryIdx == index
                                            ? Text(
                                                _categoryList[index],
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 22
                                                )
                                            )
                                            : Text(
                                                _categoryList[index],
                                                style: const TextStyle(
                                                    color: Color(0xFF898989),
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 18
                                                )
                                            )
                                          )
                                      );
                                    },
                                    onPageChanged: (index) {
                                      _curCategoryIdx = index;
                                    }
                                )
                                : PageView.builder(
                                    controller: _orderController,
                                    itemCount: _orderList.length,
                                    itemBuilder: (context, index) {
                                      return Center(
                                          child: Text(
                                              _orderList[index],
                                              style: TextStyle(
                                                  color: _curOrderIdx == index ? Colors.black : const Color(0xFF898989),
                                                  fontWeight: _curOrderIdx == index ? FontWeight.w500 : FontWeight.w300,
                                                  fontSize: _curOrderIdx == index ? 22 : 18
                                              )
                                          )
                                      );
                                    },
                                    onPageChanged: (index) {
                                      _curOrderIdx = index;
                                    }
                                ),
                                Positioned(
                                    left: 20,
                                    child: SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: IconButton(
                                        padding: const EdgeInsets.all(0.0),
                                        icon: SvgPicture.asset("assets/icons/move_left_arrow_icon.svg"),
                                        onPressed: () {
                                          if (i == 0) {
                                            _curCategoryIdx == 0 ? _curCategoryIdx = _categoryList.length - 1 : _curCategoryIdx--;
                                            _categoryController.animateToPage(
                                              _curCategoryIdx,
                                              duration: const Duration(milliseconds: 350),
                                              curve: Curves.easeIn,
                                            );
                                          } else {
                                            _curOrderIdx == 0 ? _curOrderIdx = _orderList.length - 1 : _curOrderIdx--;
                                            _orderController.animateToPage(
                                              _curOrderIdx,
                                              duration: const Duration(milliseconds: 350),
                                              curve: Curves.easeIn,
                                            );
                                          }
                                        },
                                      ),
                                    )
                                ),
                                Positioned(
                                    right: 20,
                                    child: SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: IconButton(
                                        padding: const EdgeInsets.all(0.0),
                                        icon: SvgPicture.asset("assets/icons/move_right_arrow_icon.svg"),
                                        onPressed: () {
                                          if (i == 0) {
                                            _curCategoryIdx == _categoryList.length - 1 ? _curCategoryIdx = 0 : _curCategoryIdx++;
                                            _categoryController.animateToPage(
                                              _curCategoryIdx,
                                              duration: const Duration(milliseconds: 350),
                                              curve: Curves.easeIn,
                                            );
                                          } else {
                                            _curOrderIdx == _orderList.length - 1 ? _curOrderIdx = 0 : _curOrderIdx++;
                                            _orderController.animateToPage(
                                              _curOrderIdx,
                                              duration: const Duration(milliseconds: 350),
                                              curve: Curves.easeIn,
                                            );
                                          }
                                        },
                                      ),
                                    )
                                )
                              ]
                            )
                          ),
                          const SizedBox(
                              height: 20
                          ),
                        ]
                      ),
                      const SizedBox(
                          width: double.infinity,
                          child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                  "결과 맛집",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12
                                  )
                              )
                          )
                      )
                  ]
                )
            )
          )
        ]
    );
  }
}
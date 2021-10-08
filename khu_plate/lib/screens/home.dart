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
  var resList = [
    "assets/banner_images/food1.png",
    "assets/banner_images/food2.png",
    "assets/banner_images/food3.png"
  ];
  var nameList = [
    "영통 왕갈비",
    "영통 스시",
    "영통 파스타"
  ];
  var rateList = [
    "4.3",
    "4.0",
    "3.9"
  ];
  var numReviewList = [
    "25",
    "22",
    "20"
  ];

  final _thumbWheels = ["카테고리", "기준"];
  final _categoryList = ["아무거나", "한식", "일식", "중식", "양식"];
  final _orderList = ["최신순", "평점순", "리뷰순"];

  int _curCategoryIdx = 0;
  int _curOrderIdx = 0;

  final PageController _categoryController = PageController(
      keepPage: true,
      viewportFraction: 0.25
  );

  final PageController _orderController = PageController(
      keepPage: true,
      viewportFraction: 0.25
  );

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(children: const [
        Carousel(),
        SearchBar()
      ]
      ),
      Center(
          child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(children: [
                // 카테고리 선택 및 기준 선택
                for (var i = 0; i < _thumbWheels.length; i++)
                  Column(children: [
                    SizedBox(
                        width: double.infinity,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(_thumbWheels[i] + " 선택",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12)
                            )
                        )
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                        width: 80,
                        height: 7,
                        child: SvgPicture.asset(
                            "assets/icons/thumb_wheel_deco_icon.svg")
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                        height: 25,
                        child: Stack(children: [
                          i == 0
                              ? PageView.builder(
                                  controller: _categoryController,
                                  itemCount: _categoryList.length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                        child: SizedBox(
                                            width: 100,
                                            height: 25,
                                            child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _curCategoryIdx = index;
                                                  });
                                                  _categoryController.animateToPage(
                                                      index,
                                                      duration: const Duration(milliseconds: 350),
                                                      curve: Curves.easeIn
                                                  );
                                                },
                                                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                                child: Text(
                                                    _categoryList[index],
                                                    style: TextStyle(
                                                        color: _curCategoryIdx == index
                                                                ? Colors.black : const Color(0xFF898989),
                                                        fontWeight: _curCategoryIdx == index
                                                                ? FontWeight.w500
                                                                : FontWeight.w300,
                                                        fontSize: _curCategoryIdx == index
                                                                ? 22
                                                                : 18)
                                                )
                                            )
                                        )
                                    );
                                  },
                                  onPageChanged: (index) {
                                    setState(() {
                                      _curCategoryIdx = index;
                                    });
                                  })
                              : PageView.builder(
                                  controller: _orderController,
                                  itemCount: _orderList.length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                        child: SizedBox(
                                            width: 100,
                                            height: 25,
                                            child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _curOrderIdx = index;
                                                  });
                                                  _orderController.animateToPage(
                                                      index,
                                                      duration: const Duration(milliseconds: 350),
                                                      curve: Curves.easeIn);
                                                },
                                                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                                child: Text(_orderList[index],
                                                    style: TextStyle(
                                                        color: _curOrderIdx == index
                                                                ? Colors.black
                                                                : const Color(0xFF898989),
                                                        fontWeight: _curOrderIdx == index
                                                                ? FontWeight.w500
                                                                : FontWeight.w300,
                                                        fontSize: _curOrderIdx == index
                                                                ? 22
                                                                : 18)
                                                )
                                            )
                                        )
                                    );
                                  },
                                  onPageChanged: (index) {
                                    setState(() {
                                      _curOrderIdx = index;
                                    });
                                  }),
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
                                      _curCategoryIdx == 0
                                          ? _curCategoryIdx = _categoryList.length - 1
                                          : _curCategoryIdx--;
                                      _categoryController.animateToPage(
                                        _curCategoryIdx,
                                        duration: const Duration(milliseconds: 350),
                                        curve: Curves.easeIn,
                                      );
                                    } else {
                                      _curOrderIdx == 0
                                          ? _curOrderIdx = _orderList.length - 1
                                          : _curOrderIdx--;
                                      _orderController.animateToPage(
                                        _curOrderIdx,
                                        duration: const Duration(milliseconds: 350),
                                        curve: Curves.easeIn,
                                      );
                                    }
                                  },
                                ),
                              )),
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
                                      _curCategoryIdx == _categoryList.length - 1
                                          ? _curCategoryIdx = 0
                                          : _curCategoryIdx++;
                                      _categoryController.animateToPage(
                                        _curCategoryIdx,
                                        duration: const Duration(milliseconds: 350),
                                        curve: Curves.easeIn,
                                      );
                                    } else {
                                      _curOrderIdx == _orderList.length - 1
                                          ? _curOrderIdx = 0
                                          : _curOrderIdx++;
                                      _orderController.animateToPage(
                                        _curOrderIdx,
                                        duration: const Duration(milliseconds: 350),
                                        curve: Curves.easeIn,
                                      );
                                    }
                                  },
                                ),
                              ))
                        ]
                        )
                    ),
                    const SizedBox(height: 20)
                  ]
                  ),
                // 결과 맛집
                SizedBox(
                    width: double.infinity,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("결과 맛집",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12
                                  )
                              ),
                              SizedBox(
                                  width: 45,
                                  height: 11,
                                  child: TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero
                                      ),
                                      child: Row(
                                        children: [
                                          const Text('더보기',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF898989)
                                              )
                                          ),
                                          const SizedBox(width: 4),
                                          SizedBox(
                                              width: 6,
                                              height: 11,
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
                    )
                ),
                const SizedBox(height: 20),
                // 맛집 정렬
                SingleChildScrollView(
                    padding: const EdgeInsets.only(left: 20),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < resList.length; i++)
                            Padding(
                                padding: const EdgeInsets.only(right: 10, bottom: 5),
                                child: Container(
                                    width: 140,
                                    height: 190,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Color.fromRGBO(0, 0, 0, 0.5),
                                              offset: Offset(0.0, 2.0),
                                              blurRadius: 2.0,
                                              spreadRadius: 0.0
                                          )
                                        ]
                                    ),
                                    child: Column(children: [
                                      Container(
                                        width: 140,
                                        height: 140,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            image: DecorationImage(
                                                image: AssetImage(resList[i]),
                                                fit: BoxFit.cover
                                            )
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(children: [
                                            SizedBox(
                                                width: double.infinity,
                                                child: Text(
                                                  nameList[i],
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 12),
                                                )
                                            ),
                                            const SizedBox(height: 5),
                                            SizedBox(
                                                width: double.infinity,
                                                child: Row(children: [
                                                  SizedBox(
                                                    width: 11,
                                                    height: 11,
                                                    child: SvgPicture.asset("assets/icons/star_filled_icon.svg"),
                                                  ),
                                                  const SizedBox(width: 2),
                                                  Text(
                                                    rateList[i],
                                                    style: const TextStyle(
                                                        fontSize: 10
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                      "(" + numReviewList[i] + "개 리뷰)",
                                                      style: const TextStyle(
                                                          color: Color(0xFF898989),
                                                          fontSize: 10)
                                                  )
                                                ]
                                                )
                                            )
                                          ]
                                          )
                                      )
                                    ]
                                    )
                                )
                            )
                        ]
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

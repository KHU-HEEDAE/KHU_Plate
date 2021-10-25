import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khu_plate/api/food_api.dart';
import 'package:khu_plate/model/food.dart';
import 'package:khu_plate/modules/write_review_screen_arguments.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class ResInfo extends StatefulWidget {
  const ResInfo({Key? key, required this.id}) : super(key: key);

  @override
  _ResInfoState createState() => _ResInfoState();

  final int id;
}

class _ResInfoState extends State<ResInfo> with TickerProviderStateMixin {
  @override
  @mustCallSuper
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.addListener(() {
        _scrollController.offset < 125.0
            ? setState(() {
                txtColor = Colors.black;
                btnColor = const Color(0xFF898989);
              })
            : setState(() {
                txtColor = Colors.white;
                btnColor = Colors.white;
              });
      });
    });
    resData = _getFood();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<Food> _getFood() async {
    return await FoodApi.getFood(widget.id.toString());
  }

  Future<Food>? resData;

  final ScrollController _scrollController = ScrollController();

  Color txtColor = Colors.black;
  Color btnColor = const Color(0xFF898989);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: FutureBuilder(
              future: resData,
              builder: (context, AsyncSnapshot<Food> snapshot) {
                Widget child = const SizedBox();

                if (snapshot.connectionState == ConnectionState.waiting) {
                  child = const SizedBox();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    String _tel = '';

                    if (snapshot.data!.tel.length == 11) {
                      _tel = snapshot.data!.tel.substring(0, 3) + '-' + snapshot.data!.tel.substring(3, 7) + '-' + snapshot.data!.tel.substring(7);
                    } else if (snapshot.data!.tel.length == 10) {
                      _tel = snapshot.data!.tel.substring(0, 3) + '-' + snapshot.data!.tel.substring(3, 6) + '-' + snapshot.data!.tel.substring(6);
                    } else {
                      _tel = snapshot.data!.tel;
                    }

                    child = Stack(
                        children: [
                          SizedBox(
                              height: 240,
                              child: Stack(
                                  children: [
                                    Container(
                                        height: 240,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(snapshot.data!.imgPath),
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
                          CustomScrollView(
                              controller: _scrollController,
                              slivers: [
                                SliverAppBar(
                                  floating: true,
                                  automaticallyImplyLeading: false,
                                  backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
                                  expandedHeight: 45,
                                  flexibleSpace: FlexibleSpaceBar(
                                      background: Padding(
                                          padding: const EdgeInsets.only(top: 20, left: 20),
                                          child: Container(
                                              width: 50,
                                              height: 25,
                                              padding: const EdgeInsets.only(left: 5),
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
                                  ),
                                ),
                                SliverToBoxAdapter(
                                    child: SingleChildScrollView(
                                        primary: false,
                                        scrollDirection: Axis.vertical,
                                        padding: const EdgeInsets.only(top: 100, right: 5, left: 5),
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
                                                          snapshot.data!.name,
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 24
                                                          ),
                                                        ),
                                                        const SizedBox(height: 10),
                                                        Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              if (snapshot.data!.rate.toStringAsFixed(1).split('.')[1] != '0')
                                                                for (int i = 0; i < 5; i++)
                                                                  if (i < snapshot.data!.rate.toInt())
                                                                    SizedBox(
                                                                        width: 20,
                                                                        height: 20,
                                                                        child: SvgPicture.asset("assets/icons/star_filled_icon.svg")
                                                                    )
                                                                  else if (i == snapshot.data!.rate.toInt())
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
                                                                  if (i < snapshot.data!.rate.toInt())
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
                                                                  snapshot.data!.rate.toStringAsFixed(1),
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
                                                            children: [
                                                              Text(
                                                                  snapshot.data!.address,
                                                                  style: const TextStyle(
                                                                      fontSize: 12,
                                                                      fontWeight: FontWeight.w400,
                                                                      color: Color(0xFF898989)
                                                                  )
                                                              )
                                                            ]
                                                        ),
                                                        const SizedBox(height: 10),
                                                        Row(
                                                            children: [
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    url_launcher.launch("tel://${snapshot.data!.tel}");
                                                                  },
                                                                  child: Text(
                                                                      _tel,
                                                                      style: const TextStyle(
                                                                          fontSize: 12,
                                                                          fontWeight: FontWeight.w400,
                                                                          color: Color(0xFF898989)
                                                                      )
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
                                                        Text(
                                                            "리뷰",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.w500,
                                                                color: txtColor
                                                            )
                                                        ),
                                                        const SizedBox(width: 5),
                                                        Text(
                                                            '(${snapshot.data!.reviewCount.toString()}개의 리뷰)',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w400,
                                                                color: txtColor
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
                                                                onPressed: () {
                                                                  Navigator.of(context).pushNamed(
                                                                      '/write-review',
                                                                      arguments: WriteReviewScreenArguments(
                                                                          widget.id,
                                                                          snapshot.data!.imgPath,
                                                                          snapshot.data!.name,
                                                                          snapshot.data!.rate,
                                                                          snapshot.data!.reviewCount
                                                                      )
                                                                  );
                                                                },
                                                                style: TextButton.styleFrom(
                                                                    padding: EdgeInsets.zero
                                                                ),
                                                                child: Row(
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: [
                                                                      Text('리뷰하기',
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: btnColor
                                                                          )
                                                                      ),
                                                                      const SizedBox(width: 4),
                                                                      SizedBox(
                                                                          width: 6,
                                                                          height: 16,
                                                                          child: SvgPicture.asset(
                                                                            "assets/icons/right_arrow_icon.svg",
                                                                            color: btnColor,
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
                                              if (snapshot.data!.reviews.isNotEmpty)
                                                Column(
                                                    children: [
                                                      for (var i = 0; i < snapshot.data!.reviews.length; i++)
                                                        Padding(
                                                            padding: const EdgeInsets.only(bottom: 20, left: 5, right: 5),
                                                            child: Container(
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
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                                                                    backgroundImage: AssetImage(snapshot.data!.reviews[i].avatarPath)
                                                                                )
                                                                            ),
                                                                            const SizedBox(width: 10),
                                                                            Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                      snapshot.data!.reviews[i].username,
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
                                                                                            snapshot.data!.reviews[i].rate.toStringAsFixed(1),
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
                                                                      if (snapshot.data!.reviews[i].content != '')
                                                                        Padding(
                                                                            padding: const EdgeInsets.only(bottom: 10),
                                                                            child: Text(
                                                                                snapshot.data!.reviews[i].content,
                                                                                style: const TextStyle(fontSize: 12)
                                                                            )
                                                                        ),
                                                                      if (snapshot.data!.reviews[i].imgPath != '')
                                                                        Container(
                                                                            width: 280,
                                                                            height: 140,
                                                                            decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                                image: DecorationImage(
                                                                                    image: AssetImage(snapshot.data!.reviews[i].imgPath),
                                                                                    fit: BoxFit.cover)
                                                                            )
                                                                        )
                                                                    ]
                                                                )
                                                            )
                                                        )
                                                    ]
                                                )
                                              else
                                                Padding(
                                                    padding: const EdgeInsets.only(bottom: 20, left: 5, right: 5),
                                                    child: Container(
                                                        alignment: Alignment.center,
                                                        width: 320,
                                                        padding: const EdgeInsets.all(20),
                                                        child: const Text(
                                                          '첫 리뷰를 작성해 보세요!',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontStyle: FontStyle.italic,
                                                              color: Color(0xFF888888)
                                                          ),
                                                        )
                                                    )
                                                )
                                            ]
                                        )
                                    )
                                )
                              ]
                          )
                        ]
                    );
                  } else if (snapshot.hasError) {
                    child = Text('data: ${snapshot.data},\nerror: ${snapshot.error}');
                  } else {
                    child = const Text('connection error');
                  }
                }

                return child;
              }
            )
        )
    );
  }
}
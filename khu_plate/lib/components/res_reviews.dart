import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';

class ResReviews extends StatefulWidget {
  const ResReviews({Key? key, required this.data}) : super(key: key);

  @override
  _ResReviewsState createState() => _ResReviewsState();

  final String data;
}

class _ResReviewsState extends State<ResReviews> {
  Future<Map<String, List<dynamic>>> _getData() async {
    await Future.delayed(const Duration(seconds: 2));

    return {
      "avatarList": [
        "assets/banner_images/food1.png",
        null,
        "assets/banner_images/food3.png"
      ],
      "usernameList": [
        "학식러",
        "지나가던 희대인",
        "통학시러"
      ],
      "rateList": [
        "5.0",
        "4.7",
        "4.1"
      ],
      "reviewList": [
        widget.data + " 가성비 강자!\n가격만 좋은 게 아니라 맛있기까지 해요!\n경희대 근처 맛집으로 강추!",
        null,
        widget.data + " 정말 맛있어요~"
      ],
      "foodImgList": [
        "assets/banner_images/food1.png",
        "assets/banner_images/food2.png",
        null
      ]
    };
  }

  Future<Map<String, List<dynamic>>>? resData;

  @override
  void initState() {
    super.initState();

    resData = _getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
              future: resData,
              builder: (context, AsyncSnapshot<Map<String, List<dynamic>>> snapshot) {
                Widget child = const SizedBox();

                if (snapshot.connectionState == ConnectionState.waiting) {
                  child = Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                        width: 320,
                        height: 180,
                        decoration: const BoxDecoration(
                            color: Color(0xFFD8D8D8),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.5),
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 4.0,
                                  spreadRadius: 0.0
                              )
                            ]
                        ),
                        child: const Center(
                            child: SizedBox(
                                height: 100,
                                width: 100,
                                child: CircularProgressIndicator(
                                    strokeWidth: 3
                                )
                            )
                        )
                    )
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    child = Column(
                        children: [
                          for (var i = 0; i < snapshot.data!["usernameList"]!.length; i++)
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
                                                        backgroundImage: snapshot.data!["avatarList"]![i] != null
                                                            ? AssetImage(snapshot.data!["avatarList"]![i])
                                                            : const AssetImage("assets/icons/avatar_icon.png")
                                                    )
                                                ),
                                                const SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      snapshot.data!["usernameList"]![i],
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
                                                          snapshot.data!["rateList"]![i],
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
                                          if (snapshot.data!["reviewList"]![i] != null)
                                            Padding(
                                                padding: const EdgeInsets.only(bottom: 10),
                                                child: Text(
                                                    snapshot.data!["reviewList"]![i] ?? "",
                                                    style: const TextStyle(fontSize: 12)
                                                )
                                            ),
                                          if (snapshot.data!["foodImgList"]![i] != null)
                                            Container(
                                                width: 280,
                                                height: 140,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    image: DecorationImage(
                                                        image: AssetImage(snapshot.data!["foodImgList"]![i]),
                                                        fit: BoxFit.cover)
                                                )
                                            )
                                        ]
                                    )
                                )
                            )
                        ]
                    );
                  } else if (snapshot.hasError) {
                    child = const Text('error');
                  }
                } else {
                  child = const Text('error');
                }

                return child;
              }
    );
  }
}
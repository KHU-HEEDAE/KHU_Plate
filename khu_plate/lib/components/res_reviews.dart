import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
// for http api
import 'package:khu_plate/model/review.dart';
import '../api/review_api.dart';

class ResReviews extends StatefulWidget {
  const ResReviews({Key? key, required this.reviews}) : super(key: key);

  @override
  _ResReviewsState createState() => _ResReviewsState();

  final List<Review> reviews;
}

class _ResReviewsState extends State<ResReviews> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
    /*
    return FutureBuilder(
              future: _resData,
              builder: (context, AsyncSnapshot<List<Review>> snapshot) {
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
                    if (snapshot.data!.isNotEmpty) {
                      child = Column(
                          children: [
                            for (var i = 0; i < snapshot.data!.length; i++)
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
                                                          backgroundImage: AssetImage(snapshot.data![i].avatarPath)
                                                      )
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                            snapshot.data![i].username,
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
                                                                  snapshot.data![i].rate.toStringAsFixed(1),
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
                                            if (snapshot.data![i].content != '')
                                              Padding(
                                                  padding: const EdgeInsets.only(bottom: 10),
                                                  child: Text(
                                                      snapshot.data![i].content,
                                                      style: const TextStyle(fontSize: 12)
                                                  )
                                              ),
                                            if (snapshot.data![i].imgPath != '')
                                              Container(
                                                  width: 280,
                                                  height: 140,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8),
                                                      image: DecorationImage(
                                                          image: AssetImage(snapshot.data![i].imgPath),
                                                          fit: BoxFit.cover)
                                                  )
                                              )
                                          ]
                                      )
                                  )
                              )
                          ]
                      );
                    } else {
                      child = Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 5, right: 5),
                          child: Container(
                              alignment: Alignment.center,
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
                              child: const Text(
                                '첫 리뷰를 작성해 보세요!',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500
                                ),
                              )
                          )
                      );
                    }
                  } else if (snapshot.hasError) {
                    child = Text('error: ${snapshot.error}');
                  }
                } else {
                  child = const Text('error');
                }

                return child;
              }
    );

     */
  }
}
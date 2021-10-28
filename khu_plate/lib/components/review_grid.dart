import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khu_plate/api/review_api.dart';
import 'package:khu_plate/model/review.dart';

import 'image_modal.dart';

class ReviewGrid extends StatefulWidget {
  const ReviewGrid({Key? key}) : super(key: key);

  @override
  _ReviewGridState createState() => _ReviewGridState();
}

class _ReviewGridState extends State<ReviewGrid> {
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
    return StaggeredGridView.countBuilder(
        primary: false,
        padding: const EdgeInsets.all(20),
        staggeredTileBuilder: (index) => index % 7 == 0
            ? const StaggeredTile.count(2, 2)
            : const StaggeredTile.count(1, 1),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 3,
        itemCount: _reviews.length,
        itemBuilder: (context, index) {
          Widget child = const SizedBox();

          if (_reviews[index].imgPath != '') {
            child = GestureDetector(
              onTap: () async {
                await showDialog(
                    context: context,
                    builder: (_) => ImageModal(
                        page: 'grid',
                        foodId: _reviews[index].foodId,
                        username: _reviews[index].username,
                        avatarPath: _reviews[index].avatarPath,
                        rate: _reviews[index].rate,
                        imgPath: _reviews[index].imgPath,
                        content: _reviews[index].content
                    )
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(_reviews[index].imgPath),
                        fit: BoxFit.cover
                    )
                ),
                child: Stack(
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Color.fromRGBO(0, 0, 0, 0.5),
                                    Colors.transparent
                                  ]
                              )
                          )
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Row(
                            children: [
                              SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: SvgPicture.asset('assets/icons/star_filled_icon.svg')
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _reviews[index].rate.toStringAsFixed(1),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white
                                ),
                              )
                            ]
                        ),
                      )
                    ]
                )
              )
            );
          } else if (_reviews[index].content != '') {
            child = GestureDetector(
              onTap: () async {
                await showDialog(
                    context: context,
                    builder: (_) => ImageModal(
                        page: 'grid',
                        foodId: _reviews[index].foodId,
                        username: _reviews[index].username,
                        avatarPath: _reviews[index].avatarPath,
                        rate: _reviews[index].rate,
                        content: _reviews[index].content
                    )
                );
              },
              child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Color(0xFFF8F8F8)
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            children: [
                              SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: SvgPicture.asset('assets/icons/star_filled_icon.svg')
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _reviews[index].rate.toStringAsFixed(1),
                                style: const TextStyle(
                                    fontSize: 14
                                ),
                              )
                            ]
                        ),
                        const SizedBox(height: 10),
                        Text(
                            _reviews[index].content,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 13,
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF898989)
                            )
                        )
                      ]
                  )
              )
            );
          }

          return child;
        }
    );
  }
}
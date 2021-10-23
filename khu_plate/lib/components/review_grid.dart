import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khu_plate/api/review_api.dart';
import 'package:khu_plate/model/review.dart';

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
            child = Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: AssetImage(_reviews[index].imgPath),
                        fit: BoxFit.cover
                    ),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          offset: Offset(0.0, 1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.0
                      )
                    ]
                )
            );
          } else if (_reviews[index].content != '') {
            child = Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          offset: Offset(0.0, 1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.0
                      )
                    ]
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
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14
                          ),
                        )
                      ]
                    ),
                    const SizedBox(height: 10),
                    Text(
                        _reviews[index].content,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                        )
                    )
                  ]
                )
            );
          }

          return child;
        }
    );
  }
}
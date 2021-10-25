import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khu_plate/components/review_grid.dart';
import 'package:khu_plate/components/review_list.dart';
import 'package:khu_plate/components/search_bar.dart';

class ReviewFeed extends StatefulWidget {
  const ReviewFeed({Key? key}) : super(key: key);

  @override
  _ReviewFeedState createState() => _ReviewFeedState();
}

class _ReviewFeedState extends State<ReviewFeed> with TickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: SafeArea(
          child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, val) {
              return [
                SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    expandedHeight: 45,
                    flexibleSpace: const Padding(
                      padding: EdgeInsets.all(20),
                      child: SearchBar(page: 'reviewFeed')
                    ),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(60),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                offset: Offset(0.0, 4.0),
                                blurRadius: 1.0,
                                spreadRadius: 0.0
                            )
                          ]
                        ),
                        child: TabBar(
                            controller: _tabController,
                            tabs: [
                              Tab(
                                  icon: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: _tabController.index == 0
                                          ? SvgPicture.asset('assets/icons/list_icon.svg', color: Colors.black)
                                          : SvgPicture.asset('assets/icons/list_icon.svg')
                                  )
                              ),
                              Tab(
                                  icon: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: _tabController.index == 1
                                          ? SvgPicture.asset('assets/icons/review_feed_filled_icon.svg')
                                          : SvgPicture.asset('assets/icons/review_feed_icon.svg')

                                  )
                              )
                            ]
                        )
                      )
                    )
                )
              ];
            },
            body: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  ReviewList(),
                  ReviewGrid()
                ]
            ),
          )
        )
    );
  }
}
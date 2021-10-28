import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'screens/home.dart';
import 'screens/review_feed.dart';
import 'screens/write_review.dart';
import 'screens/user_info.dart';
import 'package:flutter_svg/svg.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;

  final PageController _pageController = PageController(keepPage: true);

  void _onPageChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: PageView(
            controller: _pageController,
            children: const [
              Home(),
              ReviewFeed(),
              WriteReview(),
              UserInfo()
            ],
            onPageChanged: _onPageChange,
          ),
          bottomNavigationBar: Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.20),
                    offset: Offset(0.0, -1.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.0
                )
              ]),
              height: 76,
              child: BottomNavigationBar(
                  currentIndex: _selectedIndex,
                  onTap: (index) {
                    _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn
                    );
                  },
                  selectedItemColor: Colors.black,
                  unselectedItemColor: const Color(0xFF898989),
                  showUnselectedLabels: true,
                  selectedFontSize: 10,
                  unselectedFontSize: 10,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: SizedBox(
                            width: 24,
                            height: 24,
                            child: Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: SvgPicture.asset("assets/icons/home_icon.svg")
                            )
                        ),
                        activeIcon: SizedBox(
                            width: 24,
                            height: 24,
                            child: Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: SvgPicture.asset("assets/icons/home_filled_icon.svg")
                            )
                        ),
                        label: '홈'
                    ),
                    BottomNavigationBarItem(
                        icon: SizedBox(
                            width: 24,
                            height: 24,
                            child: Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: SvgPicture.asset("assets/icons/review_feed_icon.svg")
                            )
                        ),
                        activeIcon: SizedBox(
                            width: 24,
                            height: 24,
                            child: Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: SvgPicture.asset("assets/icons/review_feed_filled_icon.svg")
                            )
                        ),
                        label: '최신리뷰'
                    ),
                    BottomNavigationBarItem(
                        icon: SizedBox(
                            width: 24,
                            height: 24,
                            child: Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: SvgPicture.asset("assets/icons/write_review_icon.svg")
                            )
                        ),
                        activeIcon: SizedBox(
                            width: 24,
                            height: 24,
                            child: Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: SvgPicture.asset("assets/icons/write_review_filled_icon.svg")
                            )
                        ),
                        label: '리뷰작성'
                    ),
                    BottomNavigationBarItem(
                        icon: SizedBox(
                            width: 24,
                            height: 24,
                            child: Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: SvgPicture.asset("assets/icons/account_icon.svg")
                            )
                        ),
                        activeIcon: SizedBox(
                            width: 24,
                            height: 24,
                            child: Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: SvgPicture.asset("assets/icons/account_filled_icon.svg")
                            )
                        ),
                        label: '내정보'
                    )
                  ]
              )
          )
        )
    );
  }
}

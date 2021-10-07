import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'screens/home.dart';
import 'screens/review_feed.dart';
import 'screens/write_review.dart';
import 'screens/more.dart';
import 'package:flutter_svg/svg.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;

  final PageController _pageController = PageController(
    keepPage: true
  );

  void _onPageChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const [
          Home(),
          ReviewFeed(),
          WriteReview(),
          More()
        ],
        onPageChanged: _onPageChange,
      ),
      bottomNavigationBar: SizedBox(
        height: 76,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            _pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
          },
          selectedItemColor: Colors.black,
          unselectedItemColor: const Color(0xFF898989),
          showUnselectedLabels: true,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          items: <BottomNavigationBarItem> [
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
                        child: SvgPicture.asset("assets/icons/home_icon.svg", color: Colors.black)
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
                        child: SvgPicture.asset("assets/icons/review_feed_icon.svg", color: Colors.black)
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
                        child: SvgPicture.asset("assets/icons/write_review_icon.svg", color: Colors.black)
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
                        child: SvgPicture.asset("assets/icons/more_icon.svg")
                    )
                ),
                activeIcon: SizedBox(
                    width: 24,
                    height: 24,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                        child: SvgPicture.asset("assets/icons/more_icon.svg", color: Colors.black)
                    )
                ),
                label: '더보기'
            )
          ]
        )
      )
    );
  }
}
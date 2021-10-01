import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'screens/home.dart';
import 'screens/review_feed.dart';
import 'screens/write_review.dart';
import 'screens/mypage.dart';
import 'package:flutter_svg/svg.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    const ReviewFeed(),
    const WriteReview(),
    const MyPage()
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KHU_Plate')
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex)
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: const Color(0xFF898989),
        showUnselectedLabels: true,
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset("icons/home_icon.svg")
            ),
            activeIcon: SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset("icons/home_icon.svg", color: Colors.black)
            ),
            label: '홈'
          ),
          BottomNavigationBarItem(
              icon: SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset("icons/review_feed_icon.svg")
              ),
              activeIcon: SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset("icons/review_feed_icon.svg", color: Colors.black)
              ),
              label: '최신리뷰'
          ),
          BottomNavigationBarItem(
              icon: SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset("icons/write_review_icon.svg")
              ),
              activeIcon: SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset("icons/write_review_icon.svg", color: Colors.black)
              ),
              label: '리뷰작성'
          ),
          BottomNavigationBarItem(
              icon: SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset("icons/mypage_icon.svg")
              ),
              activeIcon: SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset("icons/mypage_icon.svg", color: Colors.black)
              ),
              label: '더보기'
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      )
    );
  }
}
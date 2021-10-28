import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Text(
                        '마이프로필',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                        )
                      ),
                      const Expanded(child: SizedBox()),
                      SizedBox(
                          width: 75,
                          height: 20,
                          child: TextButton(
                              onPressed: () {  },
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text('계정관리',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF898989)
                                        )
                                    ),
                                    const SizedBox(width: 4),
                                    SizedBox(
                                        width: 6,
                                        height: 16,
                                        child: SvgPicture.asset(
                                          "assets/icons/right_arrow_icon.svg",
                                          color: const Color(0xFF898989),
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
                        child: const CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage("assets/icons/avatar_icon.png")
                        )
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      '[username]',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF888888)
                      ),
                    )
                  ]
                ),
                const SizedBox(height: 20),
                SizedBox(
                    width: double.infinity,
                    child: Row(
                        children: [
                          const Text(
                              '나의 맛집 컬렉션',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              )
                          ),
                          const Expanded(child: SizedBox()),
                          SizedBox(
                              width: 75,
                              height: 20,
                              child: TextButton(
                                  onPressed: () {  },
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero
                                  ),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text('수정하기',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFF898989)
                                            )
                                        ),
                                        const SizedBox(width: 4),
                                        SizedBox(
                                            width: 6,
                                            height: 16,
                                            child: SvgPicture.asset(
                                              "assets/icons/right_arrow_icon.svg",
                                              color: const Color(0xFF898989),
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
                SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                width: 140,
                                height: 190,
                                padding: const EdgeInsets.all(30),
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
                                child: SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: SvgPicture.asset("assets/icons/add_icon.svg")
                                )
                            )
                          ]
                      )
                  )
                ),
                const SizedBox(height: 20),
                SizedBox(
                    width: double.infinity,
                    child: Row(
                        children: [
                          const Text(
                              '내가 쓴 리뷰',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              )
                          ),
                          const Expanded(child: SizedBox()),
                          SizedBox(
                              width: 75,
                              height: 20,
                              child: TextButton(
                                  onPressed: () {  },
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero
                                  ),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text('수정하기',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFF898989)
                                            )
                                        ),
                                        const SizedBox(width: 4),
                                        SizedBox(
                                            width: 6,
                                            height: 16,
                                            child: SvgPicture.asset(
                                              "assets/icons/right_arrow_icon.svg",
                                              color: const Color(0xFF898989),
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
                SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: 100,
                                  height: 100,
                                  padding: const EdgeInsets.all(10),
                                  alignment: Alignment.center,
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
                                    '작성한 리뷰가 없습니다!',
                                    style: TextStyle(
                                      color: Color(0xFF888888),
                                      fontStyle: FontStyle.italic,
                                    ),
                                    textAlign: TextAlign.center
                                  )
                              )
                            ]
                        )
                    )
                ),
                const SizedBox(height: 40),
                SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)
                                )
                            )
                        ),
                        child: const Text(
                          '로 그 아 웃',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                          ),
                        ),
                        onPressed: () {}
                    )
                )
              ]
            ),
          )
        )
    );
  }
}
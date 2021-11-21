import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:khu_plate/api/review_api.dart';
import 'package:khu_plate/model/review.dart';
import '../components/search_bar.dart';
import '../model/food.dart';

class WriteReview extends StatefulWidget {
  const WriteReview({Key? key, this.food}) : super(key: key);

  final Foods? food;

  @override
  _WriteReviewState createState() => _WriteReviewState();

  static _WriteReviewState? of(BuildContext context) =>
      context.findAncestorStateOfType<_WriteReviewState>();
}

class _WriteReviewState extends State<WriteReview> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState () {
    if (widget.food != null) {
      _food = widget.food!;
    }
    super.initState();
  }

  Foods? _food;

  set food(Foods obj) => setState(() => _food = obj);

  double _rateValue = 0.0;
  File? _imageFile;
  String _reviewTxt = '';

  final _reviewTxtController = TextEditingController();

  Future<void> _selectImg(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: const Center(
          child: Text('사진을 업로드하세요!')
        ),
        content: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    _openGallery(context);
                  },
                  child: const Text('갤러리')
              ),
              const SizedBox(width: 50),
              TextButton(
                  onPressed: () {
                    _openCamera(context);
                  },
                  child: const Text('카메라')
              )
            ]
          )
        )
      );
    });
  }

  _openGallery(BuildContext context) async {
    var _img = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(_img!.path);
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var _img = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = File(_img!.path);
    });
    Navigator.of(context).pop();
  }

  Future<void> _alertWriter(BuildContext context, String info) {
    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
          title: Center(
              child: Column(
                children: [
                  info == 'success'
                  ? const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 70.0
                  )
                  : const Icon(
                      Icons.warning,
                      color: Colors.deepOrange,
                      size: 70.0
                  ),
                  const SizedBox(height: 20),
                  Text(
                      info == 'food' ? '음식점을 선택하세요!' : info == 'post' ? '연결 오류입니다.\n다시 시도해 주세요!' : '작성이 완료되었습니다!',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14
                      )
                  )
                ]
              )
          )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    String tenth = _rateValue.toStringAsFixed(1).split('.')[1];
    bool isHalfStar = tenth != '0';
    int rateInt = _rateValue.toInt();

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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '평가할 맛집 선택',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              )
                            ),
                            const SizedBox(width: 2),
                            SizedBox(
                              width: 4,
                              child: SvgPicture.asset('assets/icons/must_icon.svg')
                            )
                          ]
                        )
                    ),
                    const SizedBox(height: 10),
                    SearchBar(page: 'writeReviewPage', callback: (obj) => setState(() => _food = obj)),
                    if (_food != null)
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.5),
                                    offset: Offset(0.0, 2.0),
                                    blurRadius: 2.0,
                                    spreadRadius: 0.0
                                )
                              ]
                            ),
                            child: ListTile(
                              leading: Image.asset(
                                  _food!.imgPath,
                                  width: 50,
                                  height: 50,
                              ),
                              title: Text(_food!.name),
                              subtitle: Text(_food!.rate.toStringAsFixed(1)),
                            )
                          )
                      ),
                    const SizedBox(height: 25),
                    const SizedBox(
                        width: double.infinity,
                        child: Text(
                          '리뷰하고 싶은 맛집이 안 보인다면..?',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),
                        )
                    ),
                    const SizedBox(height: 10),
                    Row(
                        children: [
                          SizedBox(
                              width: 115,
                              height: 20,
                              child: TextButton(
                                  onPressed: () { },
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero
                                  ),
                                  child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text('음식점 등록하기',
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
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                        width: double.infinity,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                  '별점 주기',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500
                                  )
                              ),
                              const SizedBox(width: 2),
                              SizedBox(
                                  width: 4,
                                  child: SvgPicture.asset('assets/icons/must_icon.svg')
                              )
                            ]
                        )
                    ),
                    const SizedBox(height: 10),
                    Row(
                        children: [
                          Expanded(
                              child: Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    Row(
                                        children: [
                                          if (isHalfStar)
                                            for (int i = 0; i < 5; i++)
                                              if (i < rateInt)
                                                Container(
                                                    padding: const EdgeInsets.only(right: 5),
                                                    width: 45,
                                                    height: 40,
                                                    child: SvgPicture.asset("assets/icons/star_filled_icon.svg")
                                                )
                                              else if (i == rateInt)
                                                Container(
                                                    padding: const EdgeInsets.only(right: 5),
                                                    width: 45,
                                                    height: 40,
                                                    child: SvgPicture.asset("assets/icons/star_half_icon.svg")
                                                )
                                              else
                                                Container(
                                                    padding: const EdgeInsets.only(right: 5),
                                                    width: 45,
                                                    height: 40,
                                                    child: SvgPicture.asset("assets/icons/star_filled_icon.svg", color: const Color(0xFFDCDCDC))
                                                )
                                          else
                                            for (int i = 0; i < 5; i++)
                                              if (i < rateInt)
                                                Container(
                                                    padding: const EdgeInsets.only(right: 5),
                                                    width: 45,
                                                    height: 40,
                                                    child: SvgPicture.asset("assets/icons/star_filled_icon.svg")
                                                )
                                              else
                                                Container(
                                                    padding: const EdgeInsets.only(right: 5),
                                                    width: 45,
                                                    height: 40,
                                                    child: SvgPicture.asset("assets/icons/star_filled_icon.svg", color: const Color(0xFFDCDCDC))
                                                ),
                                          const SizedBox(width: 10),
                                          Text(
                                              "${_rateValue.toStringAsFixed(1)} / 5.0",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400
                                              )
                                          )
                                        ]
                                    ),
                                    SizedBox(
                                      width: 225,
                                      child: SliderTheme(
                                          data: SliderThemeData(
                                              thumbShape: SliderComponentShape.noOverlay,
                                              overlayShape: SliderComponentShape.noOverlay,
                                              valueIndicatorColor: const Color(0xFFDF9E28),
                                              valueIndicatorTextStyle: const TextStyle(
                                                  color: Colors.white
                                              ),
                                              activeTickMarkColor: Colors.transparent,
                                              inactiveTickMarkColor: Colors.transparent,
                                              trackHeight: 35,
                                              trackShape: const RectangularSliderTrackShape()
                                          ),
                                          child: Slider(
                                              value: _rateValue,
                                              min: 0.0,
                                              max: 5.0,
                                              divisions: 50,
                                              activeColor: Colors.transparent,
                                              inactiveColor: Colors.transparent,
                                              label: _rateValue.toStringAsFixed(1),
                                              onChanged: (double val) {
                                                setState(() {
                                                  _rateValue = val;
                                                });
                                              }
                                          )
                                      )
                                    )
                                  ]
                              )
                          )
                        ]
                    ),
                    const SizedBox(height: 25),
                    const SizedBox(
                        width: double.infinity,
                        child: Text(
                          '사진 추가',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),
                        )
                    ),
                    const SizedBox(height: 10),
                    Row(
                        children: [
                          _imageFile == null
                              ? GestureDetector(
                                  onTap: () {
                                    _selectImg(context);
                                  },
                                  child: Container(
                                      width: 100,
                                      height: 100,
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(4),
                                          boxShadow: const [
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
                              )
                              : Container(
                              width: 100,
                              height: 100,
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
                              child: Stack(
                                alignment: Alignment.topRight,
                                clipBehavior: Clip.none,
                                children: [
                                  Image.file(_imageFile!),
                                  Positioned(
                                    top: -10,
                                    right: -10,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _imageFile = null;
                                        });
                                      },
                                      child: Container(
                                          width: 30,
                                          height: 30,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(30),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Color.fromRGBO(0, 0, 0, 0.5),
                                                    offset: Offset(0.0, 2.0),
                                                    blurRadius: 2.0,
                                                    spreadRadius: 0.0
                                                )
                                              ]
                                          ),
                                          child: SvgPicture.asset("assets/icons/cancel_icon.svg")
                                      )
                                    )
                                  )
                              ],
                              )
                          )
                        ]
                    ),
                    const SizedBox(height: 25),
                    const SizedBox(
                        width: double.infinity,
                        child: Text(
                          '본문 추가',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),
                        )
                    ),
                    const SizedBox(height: 10),
                    Container(
                        height: 165,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Color(0xFFEEEEEE)
                        ),
                        child: Stack(
                            children: [
                              TextField(
                                controller: _reviewTxtController,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                    hintText: '어떤 경험이었나요?',
                                    hintStyle: TextStyle(
                                        color: Color(0xFF898989)
                                    ),
                                    border: InputBorder.none
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    _reviewTxt = _reviewTxtController.text;
                                  });
                                },
                                onSubmitted: (val) {
                                  setState(() {
                                    _reviewTxt = _reviewTxtController.text;
                                  });
                                },
                              ),
                              Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          color: Color(0xFFEEEEEE)
                                      ),
                                      child: Text(
                                        "${_reviewTxt.length} / 150",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF898989)
                                        ),
                                      )
                                  )
                              )
                            ]
                        )
                    ),
                    const SizedBox(height: 25),
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
                              '등 록',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white
                              ),
                            ),
                            onPressed: () async {
                              if (_food != null) {
                                try {
                                  await ReviewApi.postReview(
                                      ReviewPost(
                                          foodId: _food!.id,
                                          reviewer: '작성자',
                                          rate: _rateValue,
                                          content: _reviewTxt,
                                      )
                                  );
                                  setState(() {
                                    _food = null;
                                    _rateValue = 0.0;
                                    _imageFile = null;
                                    _reviewTxt = '';
                                    _reviewTxtController.text = '';
                                  });
                                  _alertWriter(context, 'success');
                                } catch(e) {
                                  print(e);
                                  _alertWriter(context, 'post');
                                }
                              } else {
                                _alertWriter(context, 'food');
                              }
                            }
                        )
                    )
                  ]
              )
          )
        )
    );
  }
}
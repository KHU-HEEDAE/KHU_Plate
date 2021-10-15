import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class WriteReview extends StatefulWidget {
  const WriteReview({Key? key}) : super(key: key);

  @override
  _WriteReviewState createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  String _resName = '';
  double _rateValue = 0;
  File? _imageFile;
  String _reviewTxt = '';

  final _resNameController = TextEditingController();
  final _reviewTxtController = TextEditingController();

  Future<void> _selectImg(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: const Center(
          child: Text('사진을 업로드하세요!')
        ),
        content: SingleChildScrollView(
          child: Row(
            children: [
              TextButton(
                  onPressed: () {
                    _openGallery(context);
                  },
                  child: const Text('갤러리')
              ),
              const Expanded(
                child: SizedBox()
              ),
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    children: [
                      const SizedBox(
                          width: double.infinity,
                          child: Text(
                            '평가할 맛집 선택',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                            ),
                          )
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _resNameController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            label: const Text(
                              '음식점 이름',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black
                              )
                            ),
                            suffixIcon: SizedBox(
                                width: 20,
                                height: 20,
                                child: IconButton(
                                  icon: SvgPicture.asset(
                                      "assets/icons/search_icon.svg",
                                      width: 20,
                                      height: 20,
                                      color: Colors.black
                                  ),
                                  onPressed: () {  }
                                )
                            )
                          ),
                          onChanged: (val) {
                            setState(() {
                              _resName = _resNameController.text;
                            });
                          },
                          onSubmitted: (val) {
                            setState(() {
                              _resName = _resNameController.text;
                            });
                          },
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
                      const SizedBox(
                          width: double.infinity,
                          child: Text(
                            '별점 주기',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                            ),
                          )
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            '0',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SliderTheme(
                                    data: SliderThemeData(
                                        thumbShape: SliderComponentShape.noOverlay,
                                        overlayShape: SliderComponentShape.noOverlay,
                                        valueIndicatorColor: const Color(0xFFDF9E28),
                                        valueIndicatorTextStyle: const TextStyle(
                                          color: Colors.white
                                        ),
                                        activeTickMarkColor: Colors.transparent,
                                        inactiveTickMarkColor: Colors.transparent,
                                        trackHeight: 25,
                                        trackShape: const RectangularSliderTrackShape()
                                    ),
                                    child: Slider(
                                        value: _rateValue,
                                        min: 0.0,
                                        max: 5.0,
                                        divisions: 50,
                                        activeColor: const Color(0xFFDF9E28),
                                        inactiveColor: const Color(0xFF898989),
                                        label: _rateValue.toStringAsFixed(1),
                                        onChanged: (double val) {
                                          setState(() {
                                            _rateValue = val;
                                          });
                                        }
                                    )
                                ),
                                Center(
                                  child: Text(
                                    _rateValue.toStringAsFixed(1),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white
                                    ),
                                  )
                                )
                              ]
                            )
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            '5',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400
                            ),
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
                              child: Image.file(_imageFile!)
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
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8)
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
                                    color: Colors.white
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
                        height: 30,
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
                            '등록',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white
                            ),
                          ),
                          onPressed: () {
                            print(
                              "name: $_resName\nrate: ${_rateValue.toStringAsFixed(1)}\nimage: ${_imageFile.toString()}\ntext: $_reviewTxt"
                            );
                          }
                        )
                      )
                    ]
                )
        )
    );
  }
}
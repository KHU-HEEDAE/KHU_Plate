import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khu_plate/modules/res_info_screen_arguments.dart';
import 'package:khu_plate/modules/res_list_screen_arguments.dart';
// http api
import '../model/food.dart';
import '../api/food_api.dart';
import 'custom_list_tile.dart';

typedef FoodCallback = void Function(Foods obj);

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key, required this.page, this.callback}) : super(key: key);

  final String page;
  final FoodCallback? callback;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context)!.insert(_overlayEntry);
      } else {
        _overlayEntry.remove();
      }
    });
    _focusNode.addListener(_onFocus);
    init();
  }

  _onFocus() {
    setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  List<Foods> _foods = [];
  Timer? _timer;

  void debounce(VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 500)
  }) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(duration, callback);
  }

  Future init() async {
    final foods = await FoodApi.getFoods('');
    setState(() {
      _foods = foods;
    });
  }

  Future _searchFood(String query) async => debounce(() async {
    final foods = await FoodApi.getFoods(query);

    if (!mounted) return;

    setState(() {
      _foods = foods;
    });
  });

  // 검색에 따른 사전 결과 보여주기
  final FocusNode _focusNode = FocusNode();

  late OverlayEntry _overlayEntry;

  final LayerLink _layerLink = LayerLink();

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
        builder: (context) => Positioned(
            width: widget.page == 'mainPage' ? size.width - 45 : size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: widget.page == 'mainPage' ? Offset(0.0, size.height) : Offset(0.0, size.height + 5.0),
              child: Material(
                  elevation: 4.0,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _foods.length,
                      itemBuilder: (context, index) {
                        return TextButton(
                            onPressed: () {
                              if (widget.page != 'writeReviewPage') {
                                Navigator.of(context).pushNamed(
                                    '/res-info',
                                    arguments: ResInfoScreenArguments(
                                        _foods[index].id
                                    )
                                );
                              } else {
                                Foods food = Foods(
                                    id: _foods[index].id,
                                    imgPath: _foods[index].imgPath,
                                    name: _foods[index].name,
                                    rate: _foods[index].rate,
                                    reviewCount: _foods[index].reviewCount
                                );
                                if (widget.callback != null) {
                                  widget.callback!(food);
                                }
                                _focusNode.unfocus();
                              }
                            },
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero
                            ),
                            child: CustomListTile(
                                imgPath: _foods[index].imgPath,
                                name: _foods[index].name,
                                rate: _foods[index].rate
                            )
                        );
                      }
                  )
              )
            )
        )
    );
  }

  final _searchController = TextEditingController();

  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    late Widget child;

    if (widget.page == 'mainPage') {
      child = SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                        visible: _isSearching,
                        child: Theme(
                            data: ThemeData(
                                primaryColor: Colors.white,
                                hintColor: Colors.white
                            ),
                            child: Expanded(
                                child: CompositedTransformTarget(
                                  link: _layerLink,
                                  child: TextField(
                                      focusNode: _focusNode,
                                      controller: _searchController,
                                      style: const TextStyle(color: Colors.white),
                                      cursorColor: Colors.white,
                                      decoration: const InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                          ),
                                          hintText: "음식점을 검색하세요!"
                                      ),
                                      onChanged: (val) {
                                        _searchFood(val);
                                      },
                                      onSubmitted: (val) {
                                        Navigator.of(context).pushNamed(
                                            '/res-list',
                                            arguments: ResListScreenArguments(
                                                null,
                                                null,
                                                val
                                            )
                                        );
                                      }
                                  )
                                )
                            )
                        )
                    ),
                    SizedBox(
                        child: IconButton(
                            icon: SizedBox(
                                width: 24,
                                height: 24,
                                child: _isSearching == false
                                    ? SvgPicture.asset("assets/icons/search_icon.svg")
                                    : SvgPicture.asset("assets/icons/cancel_icon.svg", color: Colors.white)
                            ),
                            onPressed: () {
                              setState(() {
                                _isSearching = !_isSearching;
                              });
                            }
                        )
                    )
                  ]
              )
          )
      );
    } else {
      child = SizedBox(
          height: 40,
          child: CompositedTransformTarget(
            link: _layerLink,
            child: TextField(
              focusNode: _focusNode,
              controller: _searchController,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF4F4F4),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  label: const Text(
                      '음식점 이름',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF898989)
                      )
                  ),
                  suffixIcon: SizedBox(
                      width: 20,
                      height: 20,
                      child: IconButton(
                          icon: _focusNode.hasFocus == false
                              ? SvgPicture.asset(
                                  "assets/icons/search_icon.svg",
                                  width: 20,
                                  height: 20,
                                  color: const Color(0xFF898989)
                              )
                              : SvgPicture.asset(
                                  "assets/icons/cancel_icon.svg",
                                  width: 20,
                                  height: 20,
                                  color: const Color(0xFF898989)
                              ),
                          onPressed: () {
                            if (_focusNode.hasFocus) {
                              _searchController.text = '';
                            }
                            _focusNode.hasFocus ? _focusNode.unfocus() : _focusNode.requestFocus();
                          }
                      )
                  )
              ),
              onChanged: (val) {
                _searchFood(val);
              }
            )
          )
      );
    }

    return child;
  }
}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khu_plate/modules/res_info_screen_arguments.dart';
// http api
import '../model/food.dart';
import '../api/food_api.dart';

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
    init();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  List<Foods> _foods = [];
  String _query = '';
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
      _query = query;
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
              offset: Offset(0.0, size.height + 5.0),
              child: Material(
                  elevation: 4.0,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _foods.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
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
                          child: ListTile(
                              leading: Image.asset(
                                  _foods[index].imgPath,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover
                              ),
                              title: Text(_foods[index].name),
                              subtitle: Text('평점: ${_foods[index].rate}')
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
                                        setState(() {
                                          _query = _searchController.text;
                                        });
                                        print("search: $_query");
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
                                child: SvgPicture.asset("assets/icons/search_icon.svg")
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
                  fillColor: const Color(0xFFEEEEEE),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.transparent),
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
                _searchFood(val);
              },
              onSubmitted: (val) {
                setState(() {
                  _query = _searchController.text;
                });
              },
            )
          )
      );
    }

    return child;
  }
}
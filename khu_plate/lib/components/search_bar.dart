import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _isSearching = false;
  String _search = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _isSearching
              ? Expanded(
                child: Theme(
                  data: ThemeData(
                      primaryColor: Colors.white,
                      accentColor: Colors.white,
                      hintColor: Colors.white
                  ),
                  child: TextField(
                      autocorrect: true,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white
                              )
                          ),
                          hintText: "음식점을 검색하세요!"
                      ),
                      onChanged: (string) {
                        setState(() {
                          _search = string;
                        });
                      },
                      onSubmitted: (string) {
                        _search = string;
                      }
                  ),
                )
              )
              : const Expanded(
                child: SizedBox(width: 0),
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
  }
}
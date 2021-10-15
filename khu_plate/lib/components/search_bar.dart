import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _isSearching = false;

  String _search = '';

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    child: TextField(
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
                        setState(() {
                          _search = _searchController.text;
                        });
                      },
                      onSubmitted: (val) {
                        setState(() {
                          _search = _searchController.text;
                        });
                        print("search: $_search");
                      }
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
  }
}
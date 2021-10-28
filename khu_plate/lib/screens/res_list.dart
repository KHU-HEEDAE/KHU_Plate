import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khu_plate/api/food_api.dart';
import 'package:khu_plate/components/custom_list_tile.dart';
import 'package:khu_plate/model/food.dart';
import 'package:khu_plate/modules/res_info_screen_arguments.dart';

class ResList extends StatefulWidget {
  const ResList({Key? key, this.categoryId, this.priorityId, this.query}) : super(key: key);

  @override
  _ResListState createState() => _ResListState();

  final int? categoryId;
  final int? priorityId;
  final String? query;
}

class _ResListState extends State<ResList> {
  @override
  initState() {
    super.initState();
    if (widget.categoryId != null) {
      _resData = _getCategory();
    } else {
      _resData = _getSearchRes();
    }
  }

  Future<List<Foods>> _getCategory() async {
    return await FoodApi.getCategory(widget.categoryId!, widget.priorityId!);
  }

  Future<List<Foods>> _getSearchRes() async {
    return await FoodApi.getFoods(widget.query!);
  }

  Future<List<Foods>>? _resData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: FutureBuilder(
          future: _resData,
          builder: (context, AsyncSnapshot<List<Foods>> snapshot) {
            Widget child = const SizedBox();

            if (snapshot.connectionState == ConnectionState.waiting) {
              child = const Center(
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                      strokeWidth: 5
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                child = CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      floating: true,
                      automaticallyImplyLeading: false,
                      backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
                      expandedHeight: 45,
                      flexibleSpace: FlexibleSpaceBar(
                          background: Padding(
                              padding: const EdgeInsets.only(top: 20, left: 20),
                              child: Container(
                                  width: 50,
                                  height: 25,
                                  padding: const EdgeInsets.only(left: 5),
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero
                                      ),
                                      child: Row(
                                          children: [
                                            SizedBox(
                                                width: 6,
                                                height: 16,
                                                child: SvgPicture.asset(
                                                  "assets/icons/left_arrow_icon.svg",
                                                  color: Colors.black,
                                                )
                                            ),
                                            const SizedBox(width: 6),
                                            const Text('뒤로',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black
                                                )
                                            )
                                          ]
                                      )
                                  )
                              )
                          )
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SingleChildScrollView(
                        primary: false,
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            const Divider(height: 1, color: Colors.black),
                            if (snapshot.data!.isNotEmpty)
                              for (var i = 0; i < snapshot.data!.length; i++)
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          '/res-info',
                                          arguments: ResInfoScreenArguments(
                                              snapshot.data![i].id
                                          )
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero
                                    ),
                                    child: CustomListTile(
                                        imgPath: snapshot.data![i].imgPath,
                                        name: snapshot.data![i].name,
                                        rate: snapshot.data![i].rate
                                    )
                                )
                            else
                              const Center(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Text(
                                        '일치하는 검색 결과가 없습니다!',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.italic,
                                            color: Color(0xFF888888)
                                        )
                                    )
                                )
                              )
                          ]
                        )
                      )
                    )
                  ]
                );
              } else if (snapshot.hasError) {
                child = Text('data: ${snapshot.data},\nerror: ${snapshot.error}');
              } else {
                child = const Text('connection error');
              }
            }

            return child;
          },
        ),
      ),
    );
  }
}
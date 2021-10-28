import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({Key? key, required this.imgPath, required this.name, required this.rate}) : super(key: key);

  final String imgPath;
  final String name;
  final double rate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: AssetImage(imgPath),
                fit: BoxFit.cover
              )
            )
          ),
          const SizedBox(width: 15),
          Expanded(
            child: SizedBox(
                height: 50,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 16,
                              height: 16,
                              child: SvgPicture.asset("assets/icons/star_filled_icon.svg")
                          ),
                          const SizedBox(width: 10),
                          Text(
                            rate.toStringAsFixed(1),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF888888)
                            ),
                          )
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      const Divider(
                          height: 1,
                          color: Color(0xFFAAAAAA)
                      )
                    ]
                )
            )
          )
        ]
      )
    );
  }
}
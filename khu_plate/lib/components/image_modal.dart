import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khu_plate/modules/res_info_screen_arguments.dart';

class ImageModal extends StatelessWidget{
  final String page;
  final int? foodId;
  final String? username;
  final String? avatarPath;
  final double? rate;
  final String? imgPath;
  final String? content;

  const ImageModal({Key? key, required this.page, this.foodId, this.username, this.avatarPath, this.rate, this.imgPath, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero
      ),
      child: page != 'grid'
        ? SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Image(
            image: AssetImage(imgPath!),
            fit: BoxFit.cover
          )
        )
        : Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imgPath != null)
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.56,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(imgPath!),
                          fit: BoxFit.cover
                      )
                  ),
                  child: Stack(
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Color.fromRGBO(0, 0, 0, 0.5),
                                      Colors.transparent
                                    ],
                                    stops: [
                                      0.3,
                                      1.0
                                    ]
                                )
                            )
                        ),
                        Positioned(
                            bottom: 10,
                            left: 20,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
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
                                            child: CircleAvatar(
                                                radius: 15,
                                                backgroundImage: AssetImage(avatarPath!)
                                            )
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                            username!,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white
                                            )
                                        )
                                      ]
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                      children: [
                                        if (rate!.toStringAsFixed(1).split('.')[1] != '0')
                                          for (int i = 0; i < 5; i++)
                                            if (i < rate!.toInt())
                                              SizedBox(
                                                  width: 14,
                                                  height: 14,
                                                  child: SvgPicture.asset("assets/icons/star_filled_icon.svg")
                                              )
                                            else if (i == rate!.toInt())
                                              SizedBox(
                                                  width: 14,
                                                  height: 14,
                                                  child: SvgPicture.asset("assets/icons/star_half_icon.svg")
                                              )
                                            else
                                              SizedBox(
                                                  width: 14,
                                                  height: 14,
                                                  child: SvgPicture.asset("assets/icons/star_filled_icon.svg", color: const Color(0xFFDCDCDC))
                                              )
                                        else
                                          for (int i = 0; i < 5; i++)
                                            if (i < rate!.toInt())
                                              SizedBox(
                                                  width: 14,
                                                  height: 14,
                                                  child: SvgPicture.asset("assets/icons/star_filled_icon.svg")
                                              )
                                            else
                                              SizedBox(
                                                  width: 14,
                                                  height: 14,
                                                  child: SvgPicture.asset("assets/icons/star_filled_icon.svg", color: const Color(0xFFDCDCDC))
                                              ),
                                        const SizedBox(width: 4),
                                        Text(
                                          rate!.toStringAsFixed(1),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white
                                          ),
                                        )
                                      ]
                                  )
                                ]
                            )
                        )
                      ]
                  )
              )
            else
              Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
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
                                  child: CircleAvatar(
                                      radius: 15,
                                      backgroundImage: AssetImage(avatarPath!)
                                  )
                              ),
                              const SizedBox(width: 10),
                              Text(
                                  username!,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black
                                  )
                              )
                            ]
                        ),
                        const SizedBox(height: 5),
                        Row(
                            children: [
                              if (rate!.toStringAsFixed(1).split('.')[1] != '0')
                                for (int i = 0; i < 5; i++)
                                  if (i < rate!.toInt())
                                    SizedBox(
                                        width: 14,
                                        height: 14,
                                        child: SvgPicture.asset("assets/icons/star_filled_icon.svg")
                                    )
                                  else if (i == rate!.toInt())
                                    SizedBox(
                                        width: 14,
                                        height: 14,
                                        child: SvgPicture.asset("assets/icons/star_half_icon.svg")
                                    )
                                  else
                                    SizedBox(
                                        width: 14,
                                        height: 14,
                                        child: SvgPicture.asset("assets/icons/star_filled_icon.svg", color: const Color(0xFFDCDCDC))
                                    )
                              else
                                for (int i = 0; i < 5; i++)
                                  if (i < rate!.toInt())
                                    SizedBox(
                                        width: 14,
                                        height: 14,
                                        child: SvgPicture.asset("assets/icons/star_filled_icon.svg")
                                    )
                                  else
                                    SizedBox(
                                        width: 14,
                                        height: 14,
                                        child: SvgPicture.asset("assets/icons/star_filled_icon.svg", color: const Color(0xFFDCDCDC))
                                    ),
                              const SizedBox(width: 4),
                              Text(
                                rate!.toStringAsFixed(1),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black
                                ),
                              )
                            ]
                        )
                      ]
                  )
              ),
            if (content != '')
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10, bottom: 20, right: 20),
                child: Text(
                  content!,
                  style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Color(0xFF898989)
                  ),
                ),
              )
            else
              const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
                child: Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    SizedBox(
                        width: 80,
                        height: 14,
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  '/res-info',
                                  arguments: ResInfoScreenArguments(
                                      foodId!
                                  )
                              );
                            },
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero
                            ),
                            child: Row(
                              children: [
                                const Text('음식점 정보',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF898989)
                                    )
                                ),
                                const SizedBox(width: 4),
                                SizedBox(
                                    width: 10,
                                    height: 14,
                                    child: SvgPicture.asset(
                                      "assets/icons/right_arrow_icon.svg",
                                      color: const Color(0xFF898989),
                                    )
                                )
                              ],
                            )
                        )
                    )
                  ]
                )
            )
          ]
      )
    );
  }
}
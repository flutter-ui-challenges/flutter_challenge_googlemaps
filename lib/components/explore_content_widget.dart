import 'package:flutter/material.dart';
import 'package:flutter_challenge_googlemaps/helper/ui_helper.dart';

class ExploreContentWidget extends StatelessWidget {
  final double currentExplorePercent;

  const ExploreContentWidget({Key key, this.currentExplorePercent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return currentExplorePercent != 0
        ? Positioned(
            top: realH(standardHeight + (162 - standardHeight) * currentExplorePercent),
            width: screenWidth,
            child: Container(
              height: screenHeight,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  Opacity(
                    opacity: currentExplorePercent,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Image.asset(
                            "assets/icon_1.png",
                            width: realH(133),
                            height: realH(133),
                          ),
                        ),
                        Expanded(
                          child: Image.asset(
                            "assets/icon_2.png",
                            width: realH(133),
                            height: realH(133),
                          ),
                        ),
                        Expanded(
                          child: Image.asset(
                            "assets/icon_3.png",
                            width: realH(133),
                            height: realH(133),
                          ),
                        )
                      ],
                    ),
                  ),
                  Transform.translate(
                      offset: Offset(0, realH(23 + 380 * (1 - currentExplorePercent))),
                      child: Opacity(
                          opacity: currentExplorePercent,
                          child: Container(
                            width: screenWidth,
                            height: realH(172),
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 22),
                                ),
                                buildListItem(1, "Authentic\nrestaurant"),
                                buildListItem(2, "Famous\nmonuments"),
                                buildListItem(3, "Weekend\ngetaways"),
                                buildListItem(1, "Authentic\nrestaurant"),
                                buildListItem(2, "Famous\nmonuments"),
                                buildListItem(3, "Weekend\ngetaways"),
                              ],
                            ),
                          ))),
                  Transform.translate(
                      offset: Offset(0, realH(58 + 570 * (1 - currentExplorePercent))),
                      child: Opacity(
                        opacity: currentExplorePercent,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: realW(22)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: realW(22)),
                                child: Text("EVENTS",
                                    style: const TextStyle(
                                        color: Colors.white54, fontSize: 13, fontWeight: FontWeight.bold)),
                              ),
                              Stack(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/dj.png",
                                  ),
                                  Positioned(
                                      top: realH(16),
                                      left: realW(24),
                                      child: Container(
                                        width: realW(150),
                                        height: realH(29),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.8),
                                            borderRadius: BorderRadius.all(Radius.circular(realW(15)))),
                                        child: Text(
                                          "Tomorrow 8pm",
                                          style: TextStyle(color: Colors.black, fontSize: realW(16)),
                                        ),
                                      )),
                                  Positioned(
                                      bottom: realH(26),
                                      left: realW(24),
                                      child: Text(
                                        "Marshmello Live in Concert",
                                        style: TextStyle(color: Colors.white, fontSize: realW(16)),
                                      ))
                                ],
                              ),
                              Transform.translate(
                                offset: Offset(0, realH(30 - 30 * (currentExplorePercent - 0.75) * 4)),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Image.asset("assets/banner_4.png"),
                                    ),
                                    Expanded(
                                      child: Image.asset("assets/banner_5.png"),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(bottom: realH(262)),
                  )
                ],
              ),
            ),
          )
        : const Padding(
            padding: const EdgeInsets.all(0),
          );
  }

  buildListItem(int index, String name) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          "assets/banner_$index.png",
          width: realH(127),
          height: realH(127),
        ),
        Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: realH(16)),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

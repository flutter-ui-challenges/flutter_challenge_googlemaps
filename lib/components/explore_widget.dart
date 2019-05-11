import 'package:flutter/material.dart';
import 'package:flutter_challenge_googlemaps/helper/ui_helper.dart';

class ExploreWidget extends StatelessWidget {
  final double currentSearchPercent;

  final double currentExplorePercent;

  final Function(bool) animateExplore;

  final Function(DragUpdateDetails) onVerticalDragUpdate;
  final Function() onPanDown;

  final bool isExploreOpen;

  const ExploreWidget(
      {Key key,
      this.currentSearchPercent,
      this.currentExplorePercent,
      this.animateExplore,
      this.isExploreOpen,
      this.onVerticalDragUpdate,
      this.onPanDown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: realH(-122 * currentSearchPercent),
        left: (screenWidth - realW(159 + (standardWidth - 159) * currentExplorePercent)) / 2,
        child: GestureDetector(
          onTap: () {
            animateExplore(!isExploreOpen);
          },
          onVerticalDragUpdate: onVerticalDragUpdate,
          onVerticalDragEnd: (_) {
            _dispatchExploreOffset();
          },
          onPanDown: (_) => onPanDown(),
          child: Opacity(
            opacity: 1 - currentSearchPercent,
            child: Container(
              alignment: Alignment.bottomCenter,
              width: realW(159 + (standardWidth - 159) * currentExplorePercent),
              height: realH(122 + (766 - 122) * currentExplorePercent),
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                    Color(0xFF5496FF),
                    Color(0xFF8739E5),
                  ]),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(realW(80 + (50 - 80) * currentExplorePercent)),
                      topRight: Radius.circular(realW(80 + (50 - 80) * currentExplorePercent)))),
              child: Stack(
                children: [
                  Positioned(
                      top: realH(65 + (-5 * currentExplorePercent)),
                      left: realW(49 + (91 - 49) * currentExplorePercent),
                      child: Text(
                        "Explore",
                        style: TextStyle(color: Colors.white, fontSize: realW(18 + (32 - 18) * currentExplorePercent)),
                      )),
                  Positioned(
                      top: realH(20 + (60 - 20) * currentExplorePercent),
                      left: realW(63 + (44 - 63) * currentExplorePercent),
                      child: Icon(
                        Icons.location_on,
                        size: realW(34),
                        color: Colors.white,
                      )),
                  Positioned(
                      top: realH(currentExplorePercent < 0.9
                          ? realH(-35)
                          : realH(-35 + (6 + 35) * (currentExplorePercent - 0.9) * 8)),
                      left: realW(63 + (170 - 63) * currentExplorePercent),
                      child: GestureDetector(
                        onTap: () {
                          animateExplore(false);
                        },
                        child: Image.asset(
                          "assets/arrow.png",
                          width: realH(35),
                          height: realH(35),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ));
  }

  /// dispatch Explore state
  ///
  /// handle it by [isExploreOpen] and [currentExplorePercent]
  void _dispatchExploreOffset() {
    if (!isExploreOpen) {
      if (currentExplorePercent < 0.3) {
        animateExplore(false);
      } else {
        animateExplore(true);
      }
    } else {
      if (currentExplorePercent > 0.6) {
        animateExplore(true);
      } else {
        animateExplore(false);
      }
    }
  }
}

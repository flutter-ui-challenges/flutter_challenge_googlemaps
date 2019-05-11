import 'package:flutter/material.dart';
import 'package:flutter_challenge_googlemaps/helper/ui_helper.dart';

class SearchWidget extends StatelessWidget {
  final double currentExplorePercent;

  final double currentSearchPercent;

  final Function(bool) animateSearch;

  final bool isSearchOpen;

  final Function(DragUpdateDetails) onHorizontalDragUpdate;

  final Function() onPanDown;

  const SearchWidget(
      {Key key,
      this.currentExplorePercent,
      this.currentSearchPercent,
      this.animateSearch,
      this.isSearchOpen,
      this.onHorizontalDragUpdate,
      this.onPanDown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: realH(53),
      right: realW((68.0 - 320) - (68.0 * currentExplorePercent) + (347 - 68.0) * currentSearchPercent),
      child: GestureDetector(
        onTap: () {
          animateSearch(!isSearchOpen);
        },
        onPanDown: (_) => onPanDown,
        onHorizontalDragUpdate: onHorizontalDragUpdate,
        onHorizontalDragEnd: (_) {
          _dispatchSearchOffset();
        },
        child: Container(
          width: realW(320),
          height: realH(71),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: realW(17)),
          child: Opacity(
            opacity: 1.0 - currentSearchPercent,
            child: Icon(
              Icons.search,
              size: realW(34),
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(realW(36))),
              boxShadow: [
                BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.3), blurRadius: realW(36)),
              ]),
        ),
      ),
    );
  }

  /// dispatch Search state
  ///
  /// handle it by [isSearchOpen] and [currentSearchPercent]
  void _dispatchSearchOffset() {
    if (!isSearchOpen) {
      if (currentSearchPercent < 0.3) {
        animateSearch(false);
      } else {
        animateSearch(true);
      }
    } else {
      if (currentSearchPercent > 0.6) {
        animateSearch(true);
      } else {
        animateSearch(false);
      }
    }
  }
}

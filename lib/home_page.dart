import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/components.dart';
import 'helper/ui_helper.dart';

class GoogleMapPage extends StatefulWidget {
  GoogleMapPage();

  @override
  State<StatefulWidget> createState() {
    return _GoogleMapState();
  }
}

class _GoogleMapState extends State<GoogleMapPage> with TickerProviderStateMixin {
  AnimationController animationControllerExplore;
  AnimationController animationControllerSearch;
  AnimationController animationControllerMenu;
  CurvedAnimation curve;
  Animation<double> animation;
  Animation<double> animationW;
  Animation<double> animationR;

  /// get currentOffset percent
  get currentExplorePercent => max(0.0, min(1.0, offsetExplore / (760.0 - 122.0)));
  get currentSearchPercent => max(0.0, min(1.0, offsetSearch / (347 - 68.0)));
  get currentMenuPercent => max(0.0, min(1.0, offsetMenu / 358));

  var offsetExplore = 0.0;
  var offsetSearch = 0.0;
  var offsetMenu = 0.0;

  bool isExploreOpen = false;
  bool isSearchOpen = false;
  bool isMenuOpen = false;

  /// search drag callback
  void onSearchHorizontalDragUpdate(details) {
    offsetSearch -= details.delta.dx;
    if (offsetSearch < 0) {
      offsetSearch = 0;
    } else if (offsetSearch > (347 - 68.0)) {
      offsetSearch = 347 - 68.0;
    }
    setState(() {});
  }

  /// explore drag callback
  void onExploreVerticalUpdate(details) {
    offsetExplore -= details.delta.dy;
    if (offsetExplore > 644) {
      offsetExplore = 644;
    } else if (offsetExplore < 0) {
      offsetExplore = 0;
    }
    setState(() {});
  }

  /// animate Explore
  ///
  /// if [open] is true , make Explore open
  /// else make Explore close
  void animateExplore(bool open) {
    animationControllerExplore = AnimationController(
        duration: Duration(
            milliseconds: 1 + (800 * (isExploreOpen ? currentExplorePercent : (1 - currentExplorePercent))).toInt()),
        vsync: this);
    curve = CurvedAnimation(parent: animationControllerExplore, curve: Curves.ease);
    animation = Tween(begin: offsetExplore, end: open ? 760.0 - 122 : 0.0).animate(curve)
      ..addListener(() {
        setState(() {
          offsetExplore = animation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          isExploreOpen = open;
        }
      });
    animationControllerExplore.forward();
  }

  void animateSearch(bool open) {
    animationControllerSearch = AnimationController(
        duration: Duration(
            milliseconds: 1 + (800 * (isSearchOpen ? currentSearchPercent : (1 - currentSearchPercent))).toInt()),
        vsync: this);
    curve = CurvedAnimation(parent: animationControllerSearch, curve: Curves.ease);
    animation = Tween(begin: offsetSearch, end: open ? 347.0 - 68.0 : 0.0).animate(curve)
      ..addListener(() {
        setState(() {
          offsetSearch = animation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          isSearchOpen = open;
        }
      });
    animationControllerSearch.forward();
  }

  void animateMenu(bool open) {
    animationControllerMenu = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    curve = CurvedAnimation(parent: animationControllerMenu, curve: Curves.ease);
    animation = Tween(begin: open ? 0.0 : 358.0, end: open ? 358.0 : 0.0).animate(curve)
      ..addListener(() {
        setState(() {
          offsetMenu = animation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          isMenuOpen = open;
        }
      });
    animationControllerMenu.forward();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: <Widget>[
            Image.asset(
              "assets/map.png",
              width: screenWidth,
              height: screenHeight,
              fit: BoxFit.cover,
            ),
            //explore
            ExploreWidget(
              currentExplorePercent: currentExplorePercent,
              currentSearchPercent: currentSearchPercent,
              animateExplore: animateExplore,
              isExploreOpen: isExploreOpen,
              onVerticalDragUpdate: onExploreVerticalUpdate,
              onPanDown: () => animationControllerExplore?.stop(),
            ),
            //blur
            offsetSearch != 0
                ? BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10 * currentSearchPercent, sigmaY: 10 * currentSearchPercent),
                    child: Container(
                      color: Colors.white.withOpacity(0.1 * currentSearchPercent),
                      width: screenWidth,
                      height: screenHeight,
                    ),
                  )
                : const Padding(
                    padding: const EdgeInsets.all(0),
                  ),
            //explore content
            ExploreContentWidget(
              currentExplorePercent: currentExplorePercent,
            ),
            //recent search
            RecentSearchWidget(
              currentSearchPercent: currentSearchPercent,
            ),
            //search menu background
            offsetSearch != 0
                ? Positioned(
                    bottom: realH(88),
                    left: realW((standardWidth - 320) / 2),
                    width: realW(320),
                    height: realH(135 * currentSearchPercent),
                    child: Opacity(
                      opacity: currentSearchPercent,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(realW(33)), topRight: Radius.circular(realW(33)))),
                      ),
                    ),
                  )
                : const Padding(
                    padding: const EdgeInsets.all(0),
                  ),
            //search menu
            SearchMenuWidget(
              currentSearchPercent: currentSearchPercent,
            ),
            //search
            SearchWidget(
              currentSearchPercent: currentSearchPercent,
              currentExplorePercent: currentExplorePercent,
              isSearchOpen: isSearchOpen,
              animateSearch: animateSearch,
              onHorizontalDragUpdate: onSearchHorizontalDragUpdate,
              onPanDown: () => animationControllerSearch?.stop(),
            ),
            //search back
            SearchBackWidget(
              currentSearchPercent: currentSearchPercent,
              animateSearch: animateSearch,
            ),
            //layer button
            MapButton(
              currentExplorePercent: currentExplorePercent,
              currentSearchPercent: currentSearchPercent,
              bottom: 243,
              offsetX: -71,
              width: 71,
              height: 71,
              isRight: false,
              icon: Icons.layers,
            ),
            //directions button
            MapButton(
              currentSearchPercent: currentSearchPercent,
              currentExplorePercent: currentExplorePercent,
              bottom: 243,
              offsetX: -68,
              width: 68,
              height: 71,
              icon: Icons.directions,
              iconColor: Colors.white,
              gradient: const LinearGradient(colors: [
                Color(0xFF59C2FF),
                Color(0xFF1270E3),
              ]),
            ),
            //my_location button
            MapButton(
              currentSearchPercent: currentSearchPercent,
              currentExplorePercent: currentExplorePercent,
              bottom: 148,
              offsetX: -68,
              width: 68,
              height: 71,
              icon: Icons.my_location,
              iconColor: Colors.blue,
            ),
            //menu button
            Positioned(
              bottom: realH(53),
              left: realW(-71 * (currentExplorePercent + currentSearchPercent)),
              child: GestureDetector(
                onTap: () {
                  animateMenu(true);
                },
                child: Opacity(
                  opacity: 1 - (currentSearchPercent + currentExplorePercent),
                  child: Container(
                    width: realW(71),
                    height: realH(71),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: realW(17)),
                    child: Icon(
                      Icons.menu,
                      size: realW(34),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(realW(36)), topRight: Radius.circular(realW(36))),
                        boxShadow: [
                          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.3), blurRadius: realW(36)),
                        ]),
                  ),
                ),
              ),
            ),
            //menu
            MenuWidget(currentMenuPercent: currentMenuPercent, animateMenu: animateMenu),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    super.dispose();
    animationControllerExplore?.dispose();
    animationControllerSearch?.dispose();
    animationControllerMenu?.dispose();
  }
}

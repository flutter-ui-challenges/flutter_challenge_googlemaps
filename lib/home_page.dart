import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provide/provide.dart';

import 'components/components.dart';
import 'helper/ui_helper.dart';
import 'home_provide.dart';

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
  Animation<double> animationExplore;
  Animation<double> animationSearch;
  Animation<double> animationMenu;

  HomeProvide mProvide;

  /// animate Explore
  ///
  /// if [open] is true , make Explore open
  /// else make Explore close
  void animateExplore(bool open) {
    animationControllerExplore = AnimationController(
        duration: Duration(
            milliseconds: 1 +
                (800 * (mProvide.isExploreOpen ? mProvide.currentExplorePercent : (1 - mProvide.currentExplorePercent)))
                    .toInt()),
        vsync: this);
    curve = CurvedAnimation(parent: animationControllerExplore, curve: Curves.ease);
    animationExplore = Tween(begin: mProvide.offsetExplore, end: open ? 760.0 - 122 : 0.0).animate(curve)
      ..addListener(() {
        mProvide.notifyChange(explore: animationExplore.value);
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          mProvide.isExploreOpen = open;
        }
      });
    animationControllerExplore.forward();
  }

  void animateSearch(bool open) {
    animationControllerSearch = AnimationController(
        duration: Duration(
            milliseconds: 1 +
                (800 * (mProvide.isSearchOpen ? mProvide.currentSearchPercent : (1 - mProvide.currentSearchPercent)))
                    .toInt()),
        vsync: this);
    curve = CurvedAnimation(parent: animationControllerSearch, curve: Curves.ease);
    animationSearch = Tween(begin: mProvide.offsetSearch, end: open ? 347.0 - 68.0 : 0.0).animate(curve)
      ..addListener(() {
        mProvide.notifyChange(search: animationSearch.value);
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          mProvide.isSearchOpen = open;
        }
      });
    animationControllerSearch.forward();
  }

  void animateMenu(bool open) {
    animationControllerMenu = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    curve = CurvedAnimation(parent: animationControllerMenu, curve: Curves.ease);
    animationMenu = Tween(begin: open ? 0.0 : 358.0, end: open ? 358.0 : 0.0).animate(curve)
      ..addListener(() {
        mProvide.notifyChange(menu: animationMenu.value);
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          mProvide.isMenuOpen = open;
        }
      });
    animationControllerMenu.forward();
  }

  @override
  Widget build(BuildContext context) {
    print("rebuild");
    screenWidth ??= MediaQuery.of(context).size.width;
    screenHeight ??= MediaQuery.of(context).size.height;
    mProvide ??= Provide.value<HomeProvide>(context);
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
            Provide<HomeProvide>(
              builder: (BuildContext context, Widget child, HomeProvide value) {
                return ExploreWidget(
                  currentExplorePercent: value.currentExplorePercent,
                  currentSearchPercent: value.currentSearchPercent,
                  animateExplore: animateExplore,
                  isExploreOpen: value.isExploreOpen,
                  onVerticalDragUpdate: value.onExploreVerticalUpdate,
                  onPanDown: () => animationControllerExplore?.stop(),
                );
              },
            ),
            //blur
            Provide<HomeProvide>(
              builder: (BuildContext context, Widget child, HomeProvide value) {
                return value.offsetSearch != 0
                    ? BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: 10 * value.currentSearchPercent, sigmaY: 10 * value.currentSearchPercent),
                        child: Container(
                          color: Colors.white.withOpacity(0.1 * value.currentSearchPercent),
                          width: screenWidth,
                          height: screenHeight,
                        ),
                      )
                    : const Padding(
                        padding: const EdgeInsets.all(0),
                      );
              },
            ),
            //explore content
            Provide<HomeProvide>(
              builder: (BuildContext context, Widget child, HomeProvide value) {
                return ExploreContentWidget(
                  currentExplorePercent: value.currentExplorePercent,
                );
              },
            ),
            //recent search
            Provide<HomeProvide>(
              builder: (BuildContext context, Widget child, HomeProvide value) {
                return RecentSearchWidget(
                  currentSearchPercent: value.currentSearchPercent,
                );
              },
            ),
            //search menu background
            Provide<HomeProvide>(
              builder: (BuildContext context, Widget child, HomeProvide value) {
                return value.offsetSearch != 0
                    ? Positioned(
                        bottom: realH(88),
                        left: realW((standardWidth - 320) / 2),
                        width: realW(320),
                        height: realH(135 * value.currentSearchPercent),
                        child: Opacity(
                          opacity: value.currentSearchPercent,
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
                      );
              },
            ),
            //search menu
            Provide<HomeProvide>(
              builder: (BuildContext context, Widget child, HomeProvide value) => SearchMenuWidget(
                    currentSearchPercent: value.currentSearchPercent,
                  ),
            ),
            //search
            Provide<HomeProvide>(
              builder: (BuildContext context, Widget child, HomeProvide value) => SearchWidget(
                    currentSearchPercent: value.currentSearchPercent,
                    currentExplorePercent: value.currentExplorePercent,
                    isSearchOpen: value.isSearchOpen,
                    animateSearch: animateSearch,
                    onHorizontalDragUpdate: value.onSearchHorizontalDragUpdate,
                    onPanDown: () => animationControllerSearch?.stop(),
                  ),
            ),
            //search back
            Provide<HomeProvide>(
              builder: (BuildContext context, Widget child, HomeProvide value) => SearchBackWidget(
                    currentSearchPercent: value.currentSearchPercent,
                    animateSearch: animateSearch,
                  ),
            ),
            //layer button
            Provide<HomeProvide>(
              builder: (BuildContext context, Widget child, HomeProvide value) => MapButton(
                    currentExplorePercent: value.currentExplorePercent,
                    currentSearchPercent: value.currentSearchPercent,
                    bottom: 243,
                    offsetX: -71,
                    width: 71,
                    height: 71,
                    isRight: false,
                    icon: Icons.layers,
                  ),
            ),
            //directions button
            Provide<HomeProvide>(
              builder: (BuildContext context, Widget child, HomeProvide value) => MapButton(
                    currentSearchPercent: value.currentSearchPercent,
                    currentExplorePercent: value.currentExplorePercent,
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
            ),
            //my_location button
            Provide<HomeProvide>(
              builder: (BuildContext context, Widget child, HomeProvide value) => MapButton(
                    currentSearchPercent: value.currentSearchPercent,
                    currentExplorePercent: value.currentExplorePercent,
                    bottom: 148,
                    offsetX: -68,
                    width: 68,
                    height: 71,
                    icon: Icons.my_location,
                    iconColor: Colors.blue,
                  ),
            ),
            //menu button
            Provide<HomeProvide>(
              builder: (BuildContext context, Widget child, HomeProvide value) => Positioned(
                    bottom: realH(53),
                    left: realW(-71 * (value.currentExplorePercent + value.currentSearchPercent)),
                    child: GestureDetector(
                      onTap: () {
                        animateMenu(true);
                      },
                      child: Opacity(
                        opacity: 1 - (value.currentSearchPercent + value.currentExplorePercent),
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
            ),
            //menu
            Provide<HomeProvide>(
                builder: (BuildContext context, Widget child, HomeProvide value) =>
                    MenuWidget(currentMenuPercent: value.currentMenuPercent, animateMenu: animateMenu)),
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

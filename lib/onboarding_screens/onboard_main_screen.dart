// @dart=2.9

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import '../main.dart';
import 'onboarding_screen.dart';
import 'package:arbor___offsets___mvp___v_15/values/colors.dart';

/// An indicator showing the currently selected page of a PageController
class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: AppColors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 6.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 1.5;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  bool isFinalOnboarding = true;
  final _controller = new PageController();

  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  List<Widget> getOnboardingScreens(BuildContext context) {
    List<Widget> onboardingScreens = <Widget>[];
    final data = json.decode(remoteConfig.getString("onboarding_screens"));
    for (var i = 0; i < data.length; i++) {
      var onscr = data[i];
      try {
        onboardingScreens.add(onboardingScreen(context, onscr["analyticsName"],
            onscr["image"], onscr["headerText"], onscr["footerText"]));
      } catch (Exception) {}
    }
    return onboardingScreens;
  }

  @override
  Widget build(BuildContext context) {
    var _onboardingScreens = getOnboardingScreens(context);

    if (_onboardingScreens.isEmpty) {
      //Navigate to login / join
    }

    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: <Widget>[
          PageView(
            controller: _controller,
            children: _onboardingScreens,
            onPageChanged: (value) {
              if (value >= _onboardingScreens.length) {
                setState(() {
                  isFinalOnboarding = false;
                });
              } else {
                setState(() {
                  isFinalOnboarding = true;
                });
              }
            },
          ),
          new Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: new Container(
              padding: const EdgeInsets.all(20.0),
              child: new Center(
                child: new DotsIndicator(
                  controller: _controller,
                  itemCount: _onboardingScreens.length,
                  onPageSelected: (int page) {
                    _controller.animateToPage(
                      page,
                      duration: _kDuration,
                      curve: _kCurve,
                    );
                  },
                ),
              ),
            ),
          ),
          new Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: new Text("awefawefwaef"),
          ),
        ],
      ),
    );
  }
}

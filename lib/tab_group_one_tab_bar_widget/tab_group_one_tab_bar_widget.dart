/*
*  tab_group_one_tab_bar_widget.dart
*  Arbor - Offsets - MVP - v.1
*
*  Created by Ed.
*  Copyright © 2018 412 Technology. All rights reserved.
    */

import 'package:arbor___offsets___mvp___v_15/dashboard_widget/dashboard_widget.dart';
import 'package:arbor___offsets___mvp___v_15/projects_widget/projects_widget.dart';
import 'package:arbor___offsets___mvp___v_15/user_account_widget/user_account_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:arbor___offsets___mvp___v_15/values/colors.dart';
import 'package:arbor___offsets___mvp___v_15/values/fonts.dart';

class TabGroupOneTabBarWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabGroupOneTabBarWidgetState();
}

class _TabGroupOneTabBarWidgetState extends State<TabGroupOneTabBarWidget> {
  List<Widget> _tabWidgets;
  List<Color> navBarImageColors;

  @override
  void initState() {
    super.initState();

    _tabWidgets = [
      ProjectsWidget(),
      DashboardWidget(() => _onTabChanged(2)),
      UserAccountWidget(),
    ];
  }

  int _currentIndex = 0;

  void _onTabChanged(int index) {
    this.setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    print(
        'Height:${MediaQuery.of(context).size.height} Width:${MediaQuery.of(context).size.width}');

    return Scaffold(
      body: _tabWidgets[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: 50,
        child: BottomNavigationBar(
          selectedLabelStyle: AppFonts.selectedNavBarLabel,
          unselectedLabelStyle: AppFonts.unselectedNavBarLabel,
          selectedItemColor: AppColors.highlightBlue,
          unselectedItemColor: Colors.black,
          //fixedColor: Color.fromARGB(255, 85, 85, 85),
          currentIndex: _currentIndex,
          onTap: (index) => this._onTabChanged(index),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/icons8-photo-editor-100.png",
                width: 26,
                height: 26,
              ),
              activeIcon: ColorFiltered(
                child: Image.asset(
                  "assets/images/icons8-photo-editor-100.png",
                  width: 26,
                  height: 26,
                ),
                colorFilter:
                    ColorFilter.mode(AppColors.highlightBlue, BlendMode.srcIn),
              ),
              label: 'Projects',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/icons8-control-panel-64.png",
                width: 26,
                height: 26,
              ),
              activeIcon: ColorFiltered(
                child: Image.asset(
                  "assets/images/icons8-control-panel-64.png",
                  width: 26,
                  height: 26,
                ),
                colorFilter:
                    ColorFilter.mode(AppColors.highlightBlue, BlendMode.srcIn),
              ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/icons8-account-100.png",
                width: 26,
                height: 26,
              ),
              activeIcon: ColorFiltered(
                child: Image.asset(
                  "assets/images/icons8-account-100.png",
                  width: 26,
                  height: 26,
                ),
                colorFilter:
                    ColorFilter.mode(AppColors.highlightBlue, BlendMode.srcIn),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

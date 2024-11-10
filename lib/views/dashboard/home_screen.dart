import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tentwenty_test/helpers/app_colors.dart';
import 'package:tentwenty_test/helpers/assets.dart';
import 'package:tentwenty_test/views/dashboard/no_data_view.dart';
import 'package:tentwenty_test/views/dashboard/search/search_screen.dart';
import 'package:tentwenty_test/views/dashboard/seat%20selection/seat_selection_screen.dart';
import 'package:tentwenty_test/views/dashboard/watch section/watch_screen.dart';

import 'components/rounded_tab_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTabIndex = 1;

  // Define different screens for each tab to ensure unique views
  final List<Widget> screens = [
    noDataView(),
    WatchScreen(),          // Watch Tab
    noDataView(),
    noDataView(),
  ];

  // Updates the selected tab index
  void _updateTabIndex(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Watch',
              style: TextStyle(fontSize: 16.px, fontWeight: FontWeight.w500, color: textColor),
            ),
            InkWell(
              onTap: () {
                // Navigate to the Search screen
                Get.to(SearchScreen());
              },
              child: SvgPicture.asset(ImageSrc.searchIcon),
            )
          ],
        ),
      ),
      body: screens[_currentTabIndex],  // Display screen based on current tab index
      bottomNavigationBar: CustomRoundedBottomNavBar(
        selectedIndex: _currentTabIndex,
        onItemSelected: _updateTabIndex,
      ),
    );
  }
}

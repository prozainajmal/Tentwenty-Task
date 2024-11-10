import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tentwenty_test/helpers/assets.dart';
import 'package:tentwenty_test/helpers/app_colors.dart';

/// CustomRoundedBottomNavBar is a bottom navigation widget


class CustomRoundedBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  // Constructor accepts the currently selected index and a callback
  // to handle item selection.
  const CustomRoundedBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 13.h,
      // padding: const EdgeInsets.only(bottom: 10), // Padding to adjust for rounded corners
      decoration: const BoxDecoration(
        color: primaryColor, // Background color of the navigation bar
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), // Rounding top-left corner
          topRight: Radius.circular(20), // Rounding top-right corner
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(

          currentIndex: selectedIndex,
          onTap: onItemSelected,
          backgroundColor: Colors.transparent,
          elevation: 0, // Removes shadow to blend with the container
          selectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(fontSize: 11.px, fontWeight: FontWeight.w700, height: 2.8),
          unselectedLabelStyle: TextStyle(fontSize: 11.px, fontWeight: FontWeight.w400, height: 2.8),
          unselectedItemColor: dartGreyColor,
          type: BottomNavigationBarType.fixed,

          // Keeps all items visible
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                ImageSrc.dashboardIcon,
                height: 18,
                width: 18,
              ),
              activeIcon: SvgPicture.asset(
                ImageSrc.selectedDashboardIcon,
                height: 18,
                width: 18,
              ),

              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                ImageSrc.watchIcon,
                height: 18,
                width: 18,
              ),
              activeIcon: SvgPicture.asset(
                ImageSrc.selectedWatchIcon,
                height: 18,
                width: 18,
              ),
              label: 'Watch',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                ImageSrc.mediaIcon,
                height: 18,
                width: 18,
              ),
              activeIcon: SvgPicture.asset(
                ImageSrc.selectedMediaIcon,
                height: 18,
                width: 18,

              ),
              label: 'Media Library',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                ImageSrc.moreIcon,
                height: 20,
                width: 20,
              ),
              activeIcon: SvgPicture.asset(
                ImageSrc.selectedMoreIcon,
                height: 18,
                width: 18,

              ),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}

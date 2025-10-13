import 'package:dri_flutter/core/constants/app_colors.dart';
import 'package:dri_flutter/core/extension/build_context_extension.dart';
import 'package:dri_flutter/core/extension/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/get_it/service_locator.dart';
import '../../../../core/services/navigation_service.dart';
import 'dashboard_screen.dart';
import 'profile_screen.dart';

class LandingConstants {
  List<String> landingNavSlug = [NavBarConstants.home, NavBarConstants.profile];

  List<BottomNavigationBarItem> navBarItem(
    BuildContext context, {
    required String activeNav,
  }) => [
    BottomNavigationBarItem(
      icon: navImage(
        isSelected: activeNav == NavBarConstants.home,
        image: Icons.home,
      ),
      label: 'Home',
      tooltip: NavBarConstants.home,
    ),

    BottomNavigationBarItem(
      icon: navImage(
        isSelected: activeNav == NavBarConstants.profile,
        image: Icons.person,
      ),
      label: 'profile',
      tooltip: NavBarConstants.profile,
    ),
  ];

  List<Widget> landingNavScreen = [DashboardScreen(), ProfileScreen()];
}

Widget navImage({required IconData image, bool isSelected = false}) => Icon(
  image,
  size: 28.w,
  color: isSelected
      ? AppColors.primaryColor
      : getIt<NavigationService>().getNavigationContext().isDark
      ? AppColors.whiteColor
      : null,
).padBottom(bottom: 5.h);

import 'package:dri_flutter/core/extension/build_context_extension.dart';
import 'package:dri_flutter/features/dashboard/presentation/screen/landing_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/get_it/service_locator.dart';
import '../../../../widget/app_exit_widget.dart';
import '../bloc/nav_bar_cubit/nav_bar_cubit.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return PopScopeWidget(
      canPop: false,
      child: BlocBuilder<NavBarCubit, String>(
        builder: (context, navState) {
          return Scaffold(
            body: IndexedStack(
              index: LandingConstants().landingNavSlug.indexOf(navState),
              children: LandingConstants().landingNavScreen,
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: context.isDark
                        ? AppColors.greyColor
                        : AppColors.navShadowColor,
                    spreadRadius: 0.r,
                    blurRadius: 2.r,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
              ),
              child: BottomNavigationBar(
                elevation: 0,
                selectedFontSize: 14.sp,
                unselectedFontSize: 12.sp,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.w800),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                backgroundColor: context.isDark
                    ? AppColors.blackColor
                    : AppColors.whiteColor,
                selectedItemColor: AppColors.primaryColor,
                unselectedItemColor: context.isDark
                    ? AppColors.whiteColor
                    : AppColors.blackColor,
                items: LandingConstants().navBarItem(
                  context,
                  activeNav: navState,
                ),
                currentIndex: LandingConstants().landingNavSlug.indexOf(
                  navState,
                ),
                onTap: (index) {
                  getIt<NavBarCubit>().changeNavBar(
                    LandingConstants().landingNavSlug[index],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../features/auth/presentation/screen/login_screen.dart';
import '../../features/support_user/presentation/screen/consignment_detail_screen.dart';
import '../../features/support_user/presentation/screen/support_user_dashbord.dart';
import 'routes_name.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    // Object? argument = settings.arguments;

    switch (settings.name) {
      case RoutesName.loginScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const LoginScreen(),
        );

      case RoutesName.supportUserDashboard:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SupportUserDashbord(),
        );
      case RoutesName.consignmentDetailScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ConsignmentDetailScreen(),
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => const LoginScreen(),
        );
    }
  }
}

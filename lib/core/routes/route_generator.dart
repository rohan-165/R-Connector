import 'package:flutter/material.dart';

import '../../features/auth/presentation/screen/login_screen.dart';
import '../../features/dashboard/presentation/screen/landing_screen.dart';
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
      case RoutesName.landingScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const LandingScreen(),
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => const LoginScreen(),
        );
    }
  }
}

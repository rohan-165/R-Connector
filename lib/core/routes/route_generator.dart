import 'package:flutter/material.dart';

import '../../features/auth/presentation/screen/login_screen.dart';
import '../../features/dashbord/presentation/screen/sign_form_screen.dart';
import '../../features/dashbord/presentation/screen/pdf_viewer_screen.dart';
import '../../features/dashbord/presentation/screen/dashboard.dart';
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

      case RoutesName.dashboard:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const DashBoard(),
        );
      case RoutesName.pdfViewerScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const PdfViewerScreen(),
        );
      case RoutesName.signFormScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SignFormScreen(),
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => const LoginScreen(),
        );
    }
  }
}

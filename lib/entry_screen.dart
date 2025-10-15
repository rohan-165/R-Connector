import 'package:r_connector/features/dashbord/presentation/screen/dashboard.dart';
import 'package:flutter/material.dart';

import 'core/services/get_it/service_locator.dart';
import 'core/services/local_storage/shared_pref_data.dart';
import 'features/auth/presentation/screen/login_screen.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  String? token;

  @override
  void initState() {
    super.initState();
    token = getIt<SharedPrefData>().getAuthToken;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (token ?? '').isNotEmpty ? const DashBoard() : const LoginScreen();
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:dri_flutter/core/extension/build_context_extension.dart';
import 'package:flutter/material.dart';

import '../../../../widget/app_bar_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(isCenterTitle: false, title: 'Dashboard'),
      body: Center(
        child: Text(
          'Dashboard Screen',
          style: context.textTheme.headlineMedium,
        ),
      ),
    );
  }
}

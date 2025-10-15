import 'package:r_connector/core/constants/app_constants.dart';
import 'package:r_connector/core/extension/build_context_extension.dart';
import 'package:r_connector/core/extension/widget_extensions.dart';
import 'package:r_connector/widget/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignFormScreen extends StatefulWidget {
  const SignFormScreen({super.key});

  @override
  State<SignFormScreen> createState() => _SignFormScreenState();
}

class _SignFormScreenState extends State<SignFormScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> tabItem = [
    ConsignmentDocTap.bill,
    ConsignmentDocTap.challan,
    ConsignmentDocTap.pragyapanPatra,
    ConsignmentDocTap.drcr,
    ConsignmentDocTap.other,
  ];
  @override
  void initState() {
    _tabController = TabController(length: tabItem.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(showBackButton: true, title: 'Consignment Document'),
      body: Column(
        children: [
          TabBar(
            tabs: tabItem
                .map(
                  (e) => Text(
                    e,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                )
                .toList(),
            controller: _tabController,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: tabItem
                  .map(
                    (e) => Center(
                      child: Text(
                        "No Data",
                        style: context.textTheme.titleLarge,
                      ),
                    ),
                  )
                  .toList(),
            ).padAll(value: 10.w),
          ),
        ],
      ),
    );
  }
}

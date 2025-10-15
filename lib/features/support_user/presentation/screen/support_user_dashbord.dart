import 'package:dri_flutter/core/extension/build_context_extension.dart';
import 'package:dri_flutter/core/extension/widget_extensions.dart';
import 'package:dri_flutter/features/support_user/data/qr_mixin.dart';
import 'package:dri_flutter/widget/app_bar_widget.dart';
import 'package:dri_flutter/widget/app_exit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupportUserDashbord extends StatefulWidget {
  const SupportUserDashbord({super.key});

  @override
  State<SupportUserDashbord> createState() => _SupportUserDashbordState();
}

class _SupportUserDashbordState extends State<SupportUserDashbord>
    with QrMixin {
  @override
  Widget build(BuildContext context) {
    return PopScopeWidget(
      canPop: false,
      child: Scaffold(
        appBar: AppBarWidget(title: 'Support User Dashboard'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Click here to scan qr Code !",
                style: context.textTheme.titleMedium,
              ).padBottom(),
              CircleAvatar(
                radius: 80.r,
                child: Icon(Icons.qr_code_2_sharp, size: 120.sp),
              ).onTap(() => qrScanStatic()).padBottom(),
            ],
          ).padHorizontal(),
        ),
      ),
    );
  }
}

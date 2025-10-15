import 'package:dri_flutter/core/common/abs_normal_state.dart';
import 'package:dri_flutter/core/common/abs_normal_view.dart';
import 'package:dri_flutter/core/constants/app_colors.dart';
import 'package:dri_flutter/core/extension/build_context_extension.dart';
import 'package:dri_flutter/core/extension/widget_extensions.dart';
import 'package:dri_flutter/core/services/get_it/service_locator.dart';
import 'package:dri_flutter/core/utils/decore_utils.dart';
import 'package:dri_flutter/features/support_user/domain/model/scan_model.dart';
import 'package:dri_flutter/features/support_user/presentation/cubit/qr_scan_cubit.dart';
import 'package:dri_flutter/widget/app_bar_widget.dart';
import 'package:dri_flutter/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routes/routes_name.dart';
import '../../../../core/services/navigation_service.dart';

class QRScanInfoScreen extends StatefulWidget {
  const QRScanInfoScreen({super.key});

  @override
  State<QRScanInfoScreen> createState() => _QRScanInfoScreenState();
}

class _QRScanInfoScreenState extends State<QRScanInfoScreen> {
  @override
  void dispose() {
    getIt<QrScanCubit>().reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(showBackButton: true, title: 'Scan Information'),
      body: BlocBuilder<QrScanCubit, AbsNormalState<ScanData>>(
        builder: (context, state) {
          ScanData data = state.data ?? ScanData();
          return AbsNormalView(
            data: data,
            absNormalStatus: state.absNormalStatus,
            child: Container(
              width: double.maxFinite,
              decoration: boxDecoration(context),
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data.off?.cn ?? '',
                    style: context.textTheme.titleLarge?.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ).padBottom(bottom: 10.h),
                  Text(
                    'Depature',
                    style: context.textTheme.labelMedium,
                  ).padBottom(bottom: 5.h),
                  Text(
                    data.off?.dpl ?? '',
                    style: context.textTheme.titleLarge,
                  ).padBottom(bottom: 5.h),
                  Divider(
                    thickness: 1.h,
                    height: 1.h,
                    color: AppColors.greyColor,
                  ).padBottom(bottom: 10.h),
                  Text(
                    'Destination',
                    style: context.textTheme.labelMedium,
                  ).padBottom(bottom: 5.h),
                  Text(
                    data.off?.dtl ?? '',
                    style: context.textTheme.titleLarge,
                  ).padBottom(bottom: 5.h),
                  Divider(
                    thickness: 1.h,
                    height: 1.h,
                    color: AppColors.greyColor,
                  ).padBottom(bottom: 10.h),
                  Text(
                    'Delivery Status',
                    style: context.textTheme.labelMedium,
                  ).padBottom(bottom: 5.h),
                  Text(
                    'Delivered',
                    style: context.textTheme.titleLarge,
                  ).padBottom(bottom: 10.h),
                  rowKeyValue(
                    context,
                    icon: Icons.person,
                    label: 'Driver Name',
                    value: data.off?.dn ?? '',
                  ),
                  rowKeyValue(
                    context,
                    icon: Icons.call_rounded,
                    label: 'Mobile No',
                    value: data.off?.dmn ?? '',
                  ),
                  rowKeyValue(
                    context,
                    icon: Icons.file_copy_outlined,
                    label: 'PAN No',
                    value: data.off?.cp ?? '',
                  ),
                  rowKeyValue(
                    context,
                    icon: Icons.car_rental_outlined,
                    label: 'Vehicle No',
                    value: data.off?.vn ?? '',
                  ),
                  rowKeyValue(
                    context,
                    icon: Icons.more_time_rounded,
                    label: 'Departure Date Time',
                    value: data.off?.ddt ?? '',
                  ),
                  10.verticalSpace,
                  Align(
                    alignment: Alignment.center,
                    child: ButtonWidget(
                      onTap: () => getIt<NavigationService>().pushNamed(
                        RoutesName.consignmentDocumentScreen,
                      ),
                      lable: 'View Document',
                      width: 0.5.sw,
                    ),
                  ),
                ],
              ),
            ).padHorizontal(horizontal: 10.w).padTop(),
          );
        },
      ),
    );
  }

  Widget rowKeyValue(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 28.sp,
          color: AppColors.primaryColor,
        ).padRight(right: 10.w),
        Expanded(
          flex: 2,
          child: Text(label, style: context.textTheme.titleMedium),
        ),
        Expanded(
          flex: 1,
          child: Text(
            ':',
            style: context.textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(value, style: context.textTheme.titleLarge),
        ),
      ],
    ).padBottom(bottom: 10.h);
  }
}

// {
//   "on": "https://vctsdri.dri.gov.np/api/common/assignedConsignmentDetail/8182011054158",
//   "off": {
//     "ci": "8182011054158",
//     "cn": "इन्फो डेभलपर्स प्रा.लि.",
//     "cp": "301515986",
//     "vn": "PRADESH2021245KHA6514",
//     "vt": "Public",
//     "dn": "kenib",
//     "dmn": "9840608081",
//     "dpd": "LALITPUR",
//     "dpl": "SANEPA",
//     "dtd": "KATHMANDU",
//     "dtl": "KATHMANDU ",
//     "ddt": "2082-02-21 17:23:25",
//     "ds": "no",
//     "rm": "test",
//     "dl": {
//       "b": "0",
//       "c": "0",
//       "p": "0",
//       "dr": "2",
//       "o": "0",
//       "cr": "0",
//       "nb": "0"
//     },
//     "ml": "0",
//     "mld": null
//   }
// }

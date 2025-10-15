import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r_connector/core/common/abs_normal_state.dart';
import 'package:r_connector/core/common/abs_normal_view.dart';
import 'package:r_connector/core/constants/app_colors.dart';
import 'package:r_connector/core/extension/build_context_extension.dart';
import 'package:r_connector/core/extension/widget_extensions.dart';
import 'package:r_connector/core/localization/app_locale.dart';
import 'package:r_connector/core/services/app_clear_service.dart';
import 'package:r_connector/core/services/get_it/service_locator.dart';
import 'package:r_connector/core/utils/decore_utils.dart';
import 'package:r_connector/features/dashbord/domain/model/file_model.dart';
import 'package:r_connector/features/dashbord/presentation/cubit/file_cubit.dart';
import 'package:r_connector/widget/app_bar_widget.dart';
import 'package:r_connector/widget/app_exit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    getIt<FileCubit>().getFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScopeWidget(
      canPop: false,
      child: Scaffold(
        appBar: AppBarWidget(
          isCenterTitle: false,
          title: 'Dashboard',
          action: [
            TextButton.icon(
              onPressed: () => AppClearService().clearAllData(),
              icon: Icon(Icons.logout, color: AppColors.whiteColor),
              label: Text(
                context.l10(AppLocale.logout),
                style: context.textTheme.titleLarge?.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<FileCubit, AbsNormalState<List<FileModel>>>(
          builder: (context, state) {
            List<FileModel> list = state.data ?? [];
            return AbsNormalView(
              absNormalStatus: state.absNormalStatus,
              data: list,
              onRetry: () => getIt<FileCubit>().getFile(),
              child: ListView.separated(
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemBuilder: (ctx, index) => Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: boxDecoration(context),
                  child: Row(
                    children: [
                      Icon(Icons.file_copy).padRight(right: 10.w),
                      Expanded(child: Text(list[index].filePath ?? '')),
                    ],
                  ),
                ),
                separatorBuilder: (ctx, index) => 10.verticalSpace,
                itemCount: list.length,
              ),
            );
          },
        ).padHorizontal(horizontal: 10.h).padVertical(vertical: 10.h),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:r_connector/core/common/abs_normal_state.dart';
import 'package:r_connector/core/common/abs_normal_view.dart';
import 'package:r_connector/core/constants/app_colors.dart';
import 'package:r_connector/core/extension/widget_extensions.dart';
import 'package:r_connector/core/routes/routes_name.dart';
import 'package:r_connector/core/services/get_it/service_locator.dart';
import 'package:r_connector/core/services/navigation_service.dart';
import 'package:r_connector/core/utils/debug_log_utils.dart';
import 'package:r_connector/features/dashbord/presentation/cubit/pdf_cubit.dart';
import 'package:r_connector/widget/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:r_connector/widget/button_widget.dart';

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({super.key});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(showBackButton: true, title: 'Scan Information'),
      body: BlocBuilder<PdfCubit, AbsNormalState<PdfModel>>(
        builder: (context, state) {
          return AbsNormalView(
            absNormalStatus: state.absNormalStatus,
            data: state.data,
            onRetry: () =>
                getIt<PdfCubit>().getPdf(filePath: state.data?.fileName ?? ''),
            child: state.data?.pdfFile == null
                ? Text("No Pdf File")
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      PDFView(
                        pdfData: state.data?.pdfFile,
                        enableSwipe: true,
                        swipeHorizontal: false,
                        autoSpacing: true,
                        pageFling: true,
                        backgroundColor: AppColors.greyColor,
                        onRender: (int? v) {
                          setState(() {
                            pages = v;
                            isReady = true;
                          });
                        },
                        onError: (error) {
                          DebugLoggerService.log(error.toString());
                        },
                        onPageError: (page, error) {
                          DebugLoggerService.log('$page: ${error.toString()}');
                        },
                        onViewCreated: (PDFViewController pdfViewController) {
                          _controller.complete(pdfViewController);
                        },
                        onPageChanged: (int? page, int? total) {
                          DebugLoggerService.log('page change: $page/$total');
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ButtonWidget(
                          onTap: () => getIt<NavigationService>().pushNamed(
                            RoutesName.signFormScreen,
                          ),
                          lable: 'Sign',
                          horizontal: 10.w,
                        ),
                      ).padBottom(),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

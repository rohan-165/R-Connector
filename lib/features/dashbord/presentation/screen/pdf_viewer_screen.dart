import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:r_connector/core/common/abs_normal_state.dart';
import 'package:r_connector/core/common/abs_normal_view.dart';
import 'package:r_connector/core/services/get_it/service_locator.dart';
import 'package:r_connector/core/utils/debug_log_utils.dart';
import 'package:r_connector/features/dashbord/presentation/cubit/file_cubit.dart';
import 'package:r_connector/features/dashbord/presentation/cubit/pdf_cubit.dart';
import 'package:r_connector/widget/app_bar_widget.dart';
import 'package:flutter/material.dart';

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
  void dispose() {
    getIt<FileCubit>().reset();
    super.dispose();
  }

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
            child: Center(
              child: PDFView(
                filePath: state.data?.pdfFile?.path ?? '',
                enableSwipe: true,
                swipeHorizontal: true,
                autoSpacing: false,
                pageFling: false,
                backgroundColor: Colors.grey,
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
            ),
          );
        },
      ),
    );
  }
}

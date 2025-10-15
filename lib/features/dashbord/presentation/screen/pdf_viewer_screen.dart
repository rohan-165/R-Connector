import 'package:r_connector/core/services/get_it/service_locator.dart';
import 'package:r_connector/features/dashbord/presentation/cubit/file_cubit.dart';
import 'package:r_connector/widget/app_bar_widget.dart';
import 'package:flutter/material.dart';

class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({super.key});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  @override
  void dispose() {
    getIt<FileCubit>().reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(showBackButton: true, title: 'Scan Information'),
      body: Center(child: Text("PDF View")),
    );
  }
}

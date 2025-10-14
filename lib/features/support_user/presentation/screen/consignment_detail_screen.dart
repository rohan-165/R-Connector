import 'package:dri_flutter/core/services/get_it/service_locator.dart';
import 'package:dri_flutter/features/support_user/domain/model/scan_model.dart';
import 'package:dri_flutter/widget/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../consignment_detail_bloc/consignment_detail_bloc.dart';

class ConsignmentDetailScreen extends StatefulWidget {
  const ConsignmentDetailScreen({super.key});

  @override
  State<ConsignmentDetailScreen> createState() =>
      _ConsignmentDetailScreenState();
}

class _ConsignmentDetailScreenState extends State<ConsignmentDetailScreen> {
  @override
  void dispose() {
    getIt<ConsignmentDetailBloc>().add(ConsignmentDetailResetEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(showBackButton: true, title: 'Consignment Detail'),
      body:
          BlocSelector<ConsignmentDetailBloc, ConsignmentDetailState, ScanData>(
            selector: (state) {
              return state.scanData;
            },
            builder: (context, state) {
              return Center(child: Text("Consignment Detail screen"));
            },
          ),
    );
  }
}

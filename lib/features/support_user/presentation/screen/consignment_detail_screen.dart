import 'package:dri_flutter/widget/app_bar_widget.dart';
import 'package:flutter/material.dart';

class ConsignmentDetailScreen extends StatefulWidget {
  const ConsignmentDetailScreen({super.key});

  @override
  State<ConsignmentDetailScreen> createState() =>
      _ConsignmentDetailScreenState();
}

class _ConsignmentDetailScreenState extends State<ConsignmentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(showBackButton: true, title: 'Consignment Detail'),
      body: Center(child: Text("Consignment Detail screen")),
    );
  }
}

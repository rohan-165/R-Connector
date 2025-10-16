import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:r_connector/core/constants/app_constants.dart';
import 'package:r_connector/core/extension/widget_extensions.dart';
import 'package:r_connector/widget/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:r_connector/widget/dropdown_widget.dart';

class SignFormScreen extends StatefulWidget {
  const SignFormScreen({super.key});

  @override
  State<SignFormScreen> createState() => _SignFormScreenState();
}

class _SignFormScreenState extends State<SignFormScreen> {
  final signPage = ValueNotifier<String>(SignPage.all);
  final certificateFileSource = ValueNotifier<String>(
    FileCertificatType.CER_OFFLINE_PATH,
  );
  final stampSource = ValueNotifier<String>(
    FileCertificatType.CER_OFFLINE_PATH,
  );
  final qrImageSource = ValueNotifier<String>(
    FileCertificatType.CER_OFFLINE_PATH,
  );
  final unsignedSource = ValueNotifier<String>(
    FileCertificatType.CER_OFFLINE_PATH,
  );
  final publicCertificateFileSource = ValueNotifier<String>(
    FileCertificatType.CER_OFFLINE_PATH,
  );
  final stampRoText = ValueNotifier<String>('');
  final List<String> _stamporTexxt = [StampOrText.stamp, StampOrText.text];
  final List<String> _signPage = [
    SignPage.all,
    SignPage.first,
    SignPage.last,
    SignPage.odd,
  ];
  final List<String> _fileCertificatType = [
    FileCertificatType.CERT_BYTES,
    FileCertificatType.CER_OFFLINE_PATH,
    FileCertificatType.CER_ONLINE_PATH,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(showBackButton: true, title: 'Sign Form'),
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: signPage,
            builder: (_, value, __) {
              return DropdownWidget<String>(
                items: (filter, loadProps) => _signPage,
              ).padBottom(bottom: 10.h);
            },
          ),
        ],
      ).padAll(),
    );
  }
}

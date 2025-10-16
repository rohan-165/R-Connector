import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:r_connector/core/constants/app_constants.dart';
import 'package:r_connector/core/extension/widget_extensions.dart';
import 'package:r_connector/widget/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:r_connector/widget/button_widget.dart';
import 'package:r_connector/widget/dropdown_widget.dart';
import 'package:r_connector/widget/text_field_widget.dart';

class SignFormScreen extends StatefulWidget {
  const SignFormScreen({super.key});

  @override
  State<SignFormScreen> createState() => _SignFormScreenState();
}

class _SignFormScreenState extends State<SignFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();
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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: signPage,
              builder: (_, value, __) {
                return DropdownWidget<String>(
                  showSearchBox: false,
                  lable: 'Select Page',
                  selectedItem: value.isNotEmpty ? value : null,
                  items: (filter, loadProps) => _signPage,
                  validator: (v) {
                    if ((v ?? '').isEmpty || v == null) {
                      return 'Please select Value';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    signPage.value = value ?? '';
                  },
                ).padBottom(bottom: 10.h);
              },
            ),
            ValueListenableBuilder(
              valueListenable: certificateFileSource,
              builder: (_, value, __) {
                return DropdownWidget<String>(
                  showSearchBox: false,
                  lable: 'File Source Certificate',
                  selectedItem: value.isNotEmpty ? value : null,
                  items: (filter, loadProps) => _fileCertificatType,
                  validator: (v) {
                    if ((v ?? '').isEmpty || v == null) {
                      return 'Please select Value';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    certificateFileSource.value = value ?? '';
                  },
                ).padBottom(bottom: 10.h);
              },
            ),
            ValueListenableBuilder(
              valueListenable: qrImageSource,
              builder: (_, value, __) {
                return DropdownWidget<String>(
                  showSearchBox: false,
                  lable: 'QR Image Source Certificate',
                  selectedItem: value.isNotEmpty ? value : null,
                  items: (filter, loadProps) => _fileCertificatType,
                  validator: (v) {
                    if ((v ?? '').isEmpty || v == null) {
                      return 'Please select Value';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    qrImageSource.value = value ?? '';
                  },
                ).padBottom(bottom: 10.h);
              },
            ),
            ValueListenableBuilder(
              valueListenable: unsignedSource,
              builder: (_, value, __) {
                return DropdownWidget<String>(
                  showSearchBox: false,
                  lable: 'Unsigned Source Certificate',
                  selectedItem: value.isNotEmpty ? value : null,
                  items: (filter, loadProps) => _fileCertificatType,
                  validator: (v) {
                    if ((v ?? '').isEmpty || v == null) {
                      return 'Please select Value';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    unsignedSource.value = value ?? '';
                  },
                ).padBottom(bottom: 10.h);
              },
            ),
            ValueListenableBuilder(
              valueListenable: stampSource,
              builder: (_, value, __) {
                return DropdownWidget<String>(
                  showSearchBox: false,
                  lable: 'Stamp Source Certificate',
                  selectedItem: value.isNotEmpty ? value : null,
                  items: (filter, loadProps) => _fileCertificatType,
                  validator: (v) {
                    if ((v ?? '').isEmpty || v == null) {
                      return 'Please select Value';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    stampSource.value = value ?? '';
                  },
                ).padBottom(bottom: 10.h);
              },
            ),
            ValueListenableBuilder(
              valueListenable: publicCertificateFileSource,
              builder: (_, value, __) {
                return DropdownWidget<String>(
                  showSearchBox: false,
                  lable: 'Public File Source Certificate',
                  selectedItem: value.isNotEmpty ? value : null,
                  items: (filter, loadProps) => _fileCertificatType,
                  validator: (v) {
                    if ((v ?? '').isEmpty || v == null) {
                      return 'Please select Value';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    publicCertificateFileSource.value = value ?? '';
                  },
                ).padBottom(bottom: 10.h);
              },
            ),

            ValueListenableBuilder(
              valueListenable: stampRoText,
              builder: (_, value, __) {
                return DropdownWidget<String>(
                  showSearchBox: false,
                  lable: 'Stamp / Text',
                  selectedItem: value.isNotEmpty ? value : null,
                  items: (filter, loadProps) => _stamporTexxt,
                  validator: (v) {
                    if ((v ?? '').isEmpty || v == null) {
                      return 'Please select Value';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    signPage.value = value ?? '';
                  },
                ).padBottom(bottom: 10.h);
              },
            ),
            TextFieldWidget(
              labelText: 'Certificate Password',
              hintText: 'Enter Password',
              controller: _password,
              validator: (value) {
                if ((value ?? '').isEmpty || value == null) {
                  return 'Please enter password';
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.text,
            ).padBottom(),
            ButtonWidget(
              onTap: () {
                if (_formKey.currentState!.validate()) {}
              },
              lable: 'Sign',
              horizontal: 0.w,
            ),
          ],
        ).padAll(),
      ),
    );
  }
}

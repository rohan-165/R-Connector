// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../widget/alert_dialog_widget.dart';

class AppAlertDialog {
  static Future<void> showAlertDialog(
    BuildContext context, {
    String? icon,
    required String lable,
    String? message,
    Widget? child,
    Function()? okTap,
    Function()? cancelTap,
    String? buttonLable,
    String? secondbuttonLable,
    EdgeInsets? contentPadding,
    bool iconColor = true,
    bool barrierDismissible = true,
  }) async {
    return await showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: AlertDialogWidget(
          icon: icon,
          iconColor: iconColor,
          lable: lable,
          message: message,
          okTap: okTap,
          cancelTap: cancelTap,
          buttonLable: buttonLable,
          secondbuttonLable: secondbuttonLable,
          child: child,
        ),
      ),
    );
  }
}

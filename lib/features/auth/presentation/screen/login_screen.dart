import 'package:r_connector/core/extension/build_context_extension.dart';
import 'package:r_connector/core/extension/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/enum.dart';
import '../../../../core/localization/app_locale.dart';
import '../../../../core/services/get_it/service_locator.dart';
import '../../../../core/services/local_storage/shared_pref_data.dart';
import '../../../../widget/button_widget.dart';
import '../../../../widget/text_field_widget.dart';
import '../login_bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    getIt<SharedPrefData>().clearAuthToken();
    super.initState();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, loginState) {
            return Form(
              key: _formKey,
              child: AutofillGroup(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'R-Connector',
                        style: context.textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ).padBottom(bottom: 20.h).padHorizontal(horizontal: 20.w),

                      Container(
                        decoration: BoxDecoration(
                          color: context.isDark
                              ? AppColors.darkGreyColor
                              : AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColors.lightGreyColor),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.greyColor,
                              blurRadius: 5.r,
                              offset: Offset(0, 0),
                              spreadRadius: 1.r,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (loginState.loginState.absNormalStatus ==
                                AbsNormalStatus.ERROR) ...{
                              Text(
                                    loginState.loginState.failure?.message ??
                                        context.l10(
                                          AppLocale
                                              .something_went_wrong_subtitle,
                                        ),
                                    textAlign: TextAlign.center,
                                    style: context.textTheme.bodyLarge
                                        ?.copyWith(color: AppColors.errorColor),
                                  )
                                  .padBottom(bottom: 20.h)
                                  .padHorizontal(horizontal: 20.w),
                            },

                            TextFieldWidget(
                                  key: UniqueKey(),
                                  autofillHints: const [AutofillHints.email],
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    size: 16.w,
                                    color: AppColors.greyColor,
                                  ),
                                  controller: _emailController,
                                  labelText: context.l10(AppLocale.email),
                                  hintText: context.l10(AppLocale.enter_email),
                                  validator: (value) {
                                    // Simple email regex pattern
                                    final emailRegex = RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                    );
                                    if (value == null || value.isEmpty) {
                                      return context.l10(AppLocale.enter_email);
                                    } else if (!emailRegex.hasMatch(value)) {
                                      return context.l10(
                                        AppLocale.enter_valid_email,
                                      );
                                    }
                                    return null;
                                  },
                                )
                                .padBottom(bottom: 20.h)
                                .padHorizontal(horizontal: 20.w),
                            TextFieldWidget(
                                  key: UniqueKey(),
                                  autofillHints: const [AutofillHints.password],
                                  prefixIcon: Icon(
                                    Icons.lock_outline_sharp,
                                    size: 16.w,
                                    color: AppColors.greyColor,
                                  ),
                                  controller: _passwordController,
                                  labelText: context.l10(AppLocale.password),
                                  hintText: context.l10(AppLocale.password),
                                  isPassword: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return context.l10(
                                        AppLocale.enter_password,
                                      );
                                    }
                                    return null;
                                  },
                                )
                                .padBottom(bottom: 10.h)
                                .padHorizontal(horizontal: 20.w),

                            ButtonWidget(
                              isLoading:
                                  loginState.loginState.absNormalStatus ==
                                  AbsNormalStatus.LOADING,
                              width: double.infinity,
                              lable: context.l10(AppLocale.login),
                              onTap: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  getIt<LoginBloc>().add(
                                    LoginSubmitEvent(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ).padHorizontal(horizontal: 15.w),
                    ],
                  ).padTop(top: 40.h),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

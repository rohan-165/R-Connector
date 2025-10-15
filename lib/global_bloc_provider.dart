// ignore_for_file: depend_on_referenced_packages

import 'package:r_connector/features/dashbord/presentation/cubit/file_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

import 'core/bloc/app_open_cubit.dart';
import 'core/bloc/internet_cubit.dart';
import 'core/bloc/language_cubit.dart';
import 'core/bloc/location_cubit.dart';
import 'core/bloc/theme_cubit.dart';
import 'core/services/get_it/service_locator.dart';
import 'features/auth/presentation/login_bloc/login_bloc.dart';

// Short helper to avoid repetitive BlocProvider boilerplate
BlocProvider<T> _p<T extends StateStreamableSource<Object?>>() =>
    BlocProvider<T>.value(value: getIt<T>());

List<SingleChildWidget> _coreBlocProvider() => [
  _p<AppOpenCubit>(),
  _p<InternetCubit>(),
  _p<ThemeCubit>(),
  _p<LanguageCubit>(),
  _p<LoginBloc>(),
  _p<LocationCubit>(),
];
List<SingleChildWidget> _supportBlocProvider() => [_p<FileCubit>()];

List<SingleChildWidget> globalBlocProvider() => [
  ..._coreBlocProvider(),
  ..._supportBlocProvider(),
];

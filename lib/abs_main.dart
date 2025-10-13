import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_jailbreak_detection_plus/flutter_jailbreak_detection_plus.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/bloc/app_open_cubit.dart';
import 'core/bloc/language_cubit.dart';
import 'core/bloc/theme_cubit.dart';
import 'core/constants/enum.dart';
import 'core/flavor/set_env_config.dart';
import 'core/localization/app_locale.dart';
import 'core/routes/route_generator.dart';
import 'core/services/get_it/service_locator.dart';
import 'core/services/navigation_service.dart';
import 'core/services/theme/dark_theme.dart';
import 'core/services/theme/light_theme.dart';
import 'core/utils/debug_log_utils.dart';
import 'entry_screen.dart';
import 'firebase_init.dart';
import 'global_bloc_provider.dart';
import 'rooted_device_screen.dart';
import 'widget/app_exit_widget.dart';
import 'widget/internet_connection_widget.dart';

abstract class AbsMain {
  Future<void> init({required Enviroment environment});
}

class MainScreen extends AbsMain {
  @override
  Future<void> init({required Enviroment environment}) async {
    WidgetsFlutterBinding.ensureInitialized();
    await _lockDeviceOrientation();
    await _initializeFirebase();
    await _loadEnvironmentFile(environment);
    await _configureDependencies();
    await _initializeLocalization();

    runApp(const MyApp());
  }

  Future<void> _lockDeviceOrientation() async {
    try {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      DebugLoggerService.log(
        "Device orientation locked to portrait.",
        level: LogLevel.info,
      );
    } catch (e) {
      DebugLoggerService.log(
        "Failed to lock device orientation: $e",
        level: LogLevel.error,
      );
    }
  }

  Future<void> _initializeFirebase() async {
    try {
      await initFirebase();
      DebugLoggerService.log(
        "Firebase initialized successfully.",
        level: LogLevel.success,
      );
    } catch (e) {
      DebugLoggerService.log(
        "Firebase initialization failed: $e",
        level: LogLevel.error,
      );
    }
  }

  Future<void> _loadEnvironmentFile(Enviroment environment) async {
    try {
      final filePath = environment == Enviroment.PROD
          ? prodEnv[keyEnvironmentFile]
          : devEnv[keyEnvironmentFile];

      if (filePath == null) {
        throw Exception("Environment file path not found.");
      }

      await dotenv.load(fileName: filePath);
      DebugLoggerService.log(
        "Environment file loaded: $filePath",
        level: LogLevel.success,
      );
    } catch (e) {
      DebugLoggerService.log(
        "Failed to load environment file: $e",
        level: LogLevel.error,
      );
    }
  }

  Future<void> _configureDependencies() async {
    try {
      await configureDependencies();
      DebugLoggerService.log(
        "Dependencies configured successfully.",
        level: LogLevel.success,
      );
    } catch (e) {
      DebugLoggerService.log(
        "Dependency configuration failed: $e",
        level: LogLevel.error,
      );
    }
  }

  Future<void> _initializeLocalization() async {
    try {
      await FlutterLocalization.instance.ensureInitialized();
      DebugLoggerService.log(
        "Localization initialized successfully.",
        level: LogLevel.success,
      );
    } catch (e) {
      DebugLoggerService.log(
        "Localization initialization failed: $e",
        level: LogLevel.error,
      );
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AppLocale {
  final ValueNotifier<bool> _isToHide = ValueNotifier<bool>(true);
  bool? _jailbroken;

  @override
  void initState() {
    init();
    initPlatformState();
    super.initState();
  }

  void init() {
    onLanguageChanged = () => setState(() {});
    getIt<ThemeCubit>().init();
    getIt<LanguageCubit>().init();
  }

  Future<void> initPlatformState() async {
    bool jailbroken;
    try {
      jailbroken = await FlutterJailbreakDetectionPlus.jailbroken;
    } on PlatformException {
      jailbroken = true;
    }

    if (!mounted) return;
    DebugLoggerService.log(
      "Deveice Rooted ::: $jailbroken ",
      level: LogLevel.debug,
    );
    setState(() {
      _jailbroken = jailbroken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: globalBlocProvider(),
      child: BlocBuilder<LanguageCubit, String>(
        builder: (context, langState) {
          return BlocBuilder<ThemeCubit, String>(
            builder: (context, themeMode) {
              return PopScopeWidget(
                canPop: false,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Column(
                    children: [
                      Expanded(
                        child: ScreenUtilInit(
                          designSize: Size(
                            MediaQuery.sizeOf(context).width,
                            MediaQuery.sizeOf(context).height,
                          ),
                          minTextAdapt: true,
                          splitScreenMode: true,
                          builder: (context, child) {
                            return Material(
                              child: MaterialApp(
                                debugShowCheckedModeBanner: false,
                                supportedLocales: localization.supportedLocales,
                                localizationsDelegates:
                                    localization.localizationsDelegates,
                                navigatorKey: NavigationService.navigatorKey,
                                onGenerateRoute: RouteGenerator.generateRoute,
                                darkTheme: darkTheme(context),
                                theme: lightTheme(context),
                                themeMode: ThemeMode.light.name == themeMode
                                    ? ThemeMode.light
                                    : ThemeMode.dark,
                                home: (_jailbroken ?? false)
                                    ? RootedDeviceScreen()
                                    : EntryScreen(),
                                title: 'DRI',
                              ),
                            );
                          },
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: _isToHide,
                        builder: (_, isToHide, __) {
                          return BlocBuilder<AppOpenCubit, bool>(
                            builder: (context, appOpenState) {
                              return InternetConnectionWidget(
                                callBack: (isConnected) {
                                  if (isConnected) {
                                    if (appOpenState) {
                                      _isToHide.value = true;
                                    } else {
                                      Future.delayed(Duration(seconds: 3), () {
                                        _isToHide.value = true;
                                      });
                                    }
                                  } else {
                                    _isToHide.value = false;
                                  }
                                },
                                offlineWidget: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: InternetConnectionMsgWidget(
                                    isConnected: false,
                                  ),
                                ),
                                onlineWidget: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: isToHide
                                      ? SizedBox.fromSize()
                                      : InternetConnectionMsgWidget(
                                          isConnected: true,
                                        ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'dart:convert';

import 'package:dri_flutter/core/common/abs_normal_state.dart';
import 'package:dri_flutter/core/common/failure_state.dart';
import 'package:dri_flutter/core/services/navigation_service.dart';
import 'package:dri_flutter/features/support_user/data/qr_mixin.dart';
import 'package:dri_flutter/features/support_user/domain/model/scan_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/enum.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../../core/services/get_it/service_locator.dart';
import '../../../../core/utils/app_toast.dart';
import '../../../../core/utils/debug_log_utils.dart';

@lazySingleton
class QrScanCubit extends Cubit<AbsNormalState<ScanData>> with QrMixin {
  QrScanCubit() : super(AbsNormalInitialState<ScanData>());

  void reset() => emit(AbsNormalInitialState<ScanData>());

  void getScanData({required String hasString}) async {
    emit(AbsNormalLoadingState<ScanData>());

    final decompressed = await decompressFromBase64(hasString);

    if (decompressed == null) {
      AppToasts.showToast(
        message: 'Failed to read QR data — invalid or corrupted code.',
        toastType: ToastType.ERROR,
      );
      getIt<NavigationService>().safePop();
      return;
    }

    DebugLoggerService.log(
      'Decompressed payload: $decompressed',
      level: LogLevel.debug,
    );

    try {
      final decoded = jsonDecode(decompressed);

      if (decoded is! Map<String, dynamic>) {
        emit(
          state.copyWith(
            absNormalStatus: AbsNormalStatus.ERROR,
            failure: Failure(message: 'Unexpected JSON structure : $decoded'),
          ),
        );
        getIt<NavigationService>().safePop();
        return;
      }

      final scanData = ScanData.fromJson(decoded);

      // getIt<ConsignmentDetailBloc>().add(
      //   ConsignmentScanDetailEvent(scanData: scanData),
      // );

      emit(
        state.copyWith(
          absNormalStatus: AbsNormalStatus.SUCCESS,
          data: scanData,
        ),
      );

      // Navigate to detail page
      getIt<NavigationService>().pushReplacementNamed(
        RoutesName.qrScanInfoScreen,
      );
    } catch (e, st) {
      DebugLoggerService.log(
        'Error parsing QR data: $e\n$st',
        level: LogLevel.error,
      );

      AppToasts.showToast(
        message: 'Invalid QR content or no data found.',
        toastType: ToastType.ERROR,
      );
      emit(
        state.copyWith(
          absNormalStatus: AbsNormalStatus.ERROR,
          failure: Failure(message: 'Invalid QR content or no data found.'),
        ),
      );

      getIt<NavigationService>().safePop();
    }
  }
}

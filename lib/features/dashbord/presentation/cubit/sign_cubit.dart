import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:r_connector/core/common/abs_normal_state.dart';
import 'package:r_connector/core/constants/enum.dart';
import 'package:r_connector/core/services/get_it/service_locator.dart';
import 'package:r_connector/core/services/navigation_service.dart';
import 'package:r_connector/features/dashbord/domain/repo/repo.dart';

@lazySingleton
class SignCubit extends Cubit<AbsNormalState> {
  SignCubit() : super(AbsNormalInitialState());

  void reset() => emit(AbsNormalInitialState());

  void signPost({
    required String filePath,
    required String signPage,
    required String certificateFileSource,
    required String stampSource,
    required String qrImageSource,
    required String unsignedSource,
    required String publicCertificateFileSource,
    required String stampRoText,
    required String password,
  }) async {
    emit(AbsNormalLoadingState());

    final resp = await getIt<DashboardRepo>().postSign(
      filePath: filePath,
      signPage: signPage,
      certificateFileSource: certificateFileSource,
      stampSource: stampSource,
      qrImageSource: qrImageSource,
      unsignedSource: unsignedSource,
      publicCertificateFileSource: publicCertificateFileSource,
      stampRoText: stampRoText,
      password: password,
    );

    resp.fold(
      (l) {
        emit(state.copyWith(absNormalStatus: AbsNormalStatus.SUCCESS));
        getIt<NavigationService>().safePop();
        getIt<NavigationService>().safePop();
      },
      (r) => emit(
        state.copyWith(absNormalStatus: AbsNormalStatus.ERROR, failure: r),
      ),
    );
  }
}

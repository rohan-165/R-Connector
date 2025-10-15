import 'package:r_connector/core/common/abs_normal_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:r_connector/core/common/failure_state.dart';
import 'package:r_connector/core/constants/enum.dart';
import 'package:r_connector/core/services/get_it/service_locator.dart';
import 'package:r_connector/core/utils/debug_log_utils.dart';
import 'package:r_connector/features/dashbord/domain/repo/repo.dart';

import '../../../../core/common/data_parsh.dart';
import '../../domain/model/file_model.dart';

@lazySingleton
class FileCubit extends Cubit<AbsNormalState<List<FileModel>>> {
  FileCubit() : super(AbsNormalInitialState<List<FileModel>>());

  void reset() => emit(AbsNormalInitialState<List<FileModel>>());

  void getFile() async {
    emit(AbsNormalLoadingState<List<FileModel>>());

    final resp = await getIt<DashboardRepo>().getFile();

    resp.fold(
      (l) {
        try {
          List<FileModel> listData = parseJson<FileModel>(
            json: l,
            fromJson: (json) => FileModel.fromMap(json),
          );
          emit(
            state.copyWith(
              absNormalStatus: AbsNormalStatus.SUCCESS,
              data: listData,
            ),
          );
        } catch (e) {
          DebugLoggerService.log("Error : $e", level: LogLevel.error);
          emit(
            state.copyWith(
              absNormalStatus: AbsNormalStatus.ERROR,
              failure: Failure(message: "Error $e"),
            ),
          );
          rethrow;
        }
      },
      (r) => emit(
        state.copyWith(absNormalStatus: AbsNormalStatus.ERROR, failure: r),
      ),
    );
  }
}

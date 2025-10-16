// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:r_connector/core/common/abs_normal_state.dart';
import 'package:r_connector/core/common/failure_state.dart';
import 'package:r_connector/core/constants/enum.dart';
import 'package:r_connector/core/services/get_it/service_locator.dart';
import 'package:r_connector/features/dashbord/domain/repo/repo.dart';

@lazySingleton
class PdfCubit extends Cubit<AbsNormalState<PdfModel>> {
  PdfCubit() : super(AbsNormalInitialState<PdfModel>());

  void reset() => emit(AbsNormalInitialState<PdfModel>());

  void getPdf({required String filePath}) async {
    emit(
      state.copyWith(
        absNormalStatus: AbsNormalStatus.LOADING,
        data: state.data?.copyWith(fileName: filePath),
      ),
    );

    final file = await getIt<DashboardRepo>().fetchPdfFile(filePath: filePath);

    if (file != null) {
      emit(
        state.copyWith(
          absNormalStatus: AbsNormalStatus.SUCCESS,
          data: state.data?.copyWith(pdfFile: file),
        ),
      );
    } else {
      emit(
        state.copyWith(
          absNormalStatus: AbsNormalStatus.ERROR,
          failure: Failure(message: 'Failed to fetch PDF'),
        ),
      );
    }
  }
}

class PdfModel {
  String? fileName;
  File? pdfFile;
  PdfModel({this.fileName, this.pdfFile});

  PdfModel copyWith({String? fileName, File? pdfFile}) {
    return PdfModel(
      fileName: fileName ?? this.fileName,
      pdfFile: pdfFile ?? this.pdfFile,
    );
  }
}

import 'package:dri_flutter/features/support_user/domain/model/scan_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'consignment_detail_event.dart';
part 'consignment_detail_state.dart';

@lazySingleton
class ConsignmentDetailBloc
    extends Bloc<ConsignmentDetailEvent, ConsignmentDetailState> {
  ConsignmentDetailBloc() : super(ConsignmentDetailInitial()) {
    on<ConsignmentDetailEvent>((event, emit) {});
    on<ConsignmentScanDetailEvent>(
      (event, emit) => emit(state.copyWith(scanData: event.scanData)),
    );
    on<ConsignmentDetailResetEvent>(
      (event, emit) => emit(ConsignmentDetailInitial()),
    );
  }
}

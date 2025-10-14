part of 'consignment_detail_bloc.dart';

sealed class ConsignmentDetailEvent {}

final class ConsignmentScanDetailEvent extends ConsignmentDetailEvent {
  final ScanData scanData;

  ConsignmentScanDetailEvent({required this.scanData});
}

final class ConsignmentDetailResetEvent extends ConsignmentDetailEvent {}

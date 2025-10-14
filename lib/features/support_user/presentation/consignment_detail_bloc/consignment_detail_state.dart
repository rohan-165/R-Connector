part of 'consignment_detail_bloc.dart';

sealed class ConsignmentDetailState extends Equatable {
  const ConsignmentDetailState({required this.scanData});

  final ScanData scanData;

  ConsignmentDetailState copyWith({ScanData? scanData});

  @override
  List<Object?> get props => [scanData];
}

final class ConsignmentDetailStateImpl extends ConsignmentDetailState {
  const ConsignmentDetailStateImpl({required super.scanData});

  @override
  ConsignmentDetailState copyWith({ScanData? scanData}) {
    return ConsignmentDetailStateImpl(scanData: scanData ?? this.scanData);
  }

  @override
  List<Object?> get props => [scanData];
}

final class ConsignmentDetailInitial extends ConsignmentDetailStateImpl {
  ConsignmentDetailInitial() : super(scanData: ScanData());
}

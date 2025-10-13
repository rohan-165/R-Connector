import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../common/abs_normal_state.dart';
import '../constants/enum.dart';
import '../mixin/location_mixin.dart';

@lazySingleton
class LocationCubit extends Cubit<AbsNormalState<LocationModel>>
    with LocationMixin {
  LocationCubit() : super(AbsNormalInitialState<LocationModel>());

  void reset() {
    emit(AbsNormalInitialState<LocationModel>());
  }

  void init() async {
    emit(AbsNormalLoadingState<LocationModel>());
    try {
      LocationModel location = await getCurrentLocation();
      emit(
        state.copyWith(
          absNormalStatus: AbsNormalStatus.SUCCESS,
          data: location,
        ),
      );
    } catch (e) {
      emit(state.copyWith(absNormalStatus: AbsNormalStatus.ERROR));
      rethrow;
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/constants/app_constants.dart';

@lazySingleton
class NavBarCubit extends Cubit<String> {
  NavBarCubit() : super(NavBarConstants.home);

  void changeNavBar(String newNavBar) {
    if (newNavBar != state) {
      emit(newNavBar);
    }
  }

  void resetNavBar() {
    emit(NavBarConstants.home);
  }
}

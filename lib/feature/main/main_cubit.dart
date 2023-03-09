import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState(selectedIndex: 0));

  int currentIndex = 0;

  void selectedPage(int index) {
    currentIndex = index;
    emit(MainState(selectedIndex: currentIndex));
  }
}

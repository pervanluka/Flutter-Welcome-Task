import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../service/api/repository/donut_repository.dart';
import 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  final DonutRepository _donutRepository;

  DataCubit(this._donutRepository) : super(DonutLoadingState()){
    loadDonuts();
  }

  Future<void> loadDonuts() async {
    emit(DonutLoadingState());
    try {
      final donuts = await _donutRepository.getDonutRequested();
      emit(DonutLoadedState(donuts));
    } catch (e) {
      emit(DonutErrorState(e.toString()));
    }
  }
}

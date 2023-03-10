import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:welcome_task/constants/enums.dart';
import 'package:welcome_task/feature/main/main_state.dart';

// class MainCubit extends Cubit<MainState> {
//   final Connectivity connectivity;
//   late StreamSubscription connectivitySubscription;
//   MainCubit(this.connectivity)
//       : super(MainState(selectedIndex: 0, status: NetworkStatus.loading)) {
//     connectivitySubscription =
//         connectivity.onConnectivityChanged.listen((resultType) {
//       if (resultType == ConnectivityResult.wifi ||
//           resultType == ConnectivityResult.mobile) {
//         emitConnectedState();
//       } else {
//         emitDisconnectedState();
//       }
//     });
//   }

//   int currentIndex = 0;

//   void selectedPage(int index) {
//     // currentIndex = index;
//     emit(state.copyWith(index: index, newStatus: NetworkStatus.connected));
//   }

//   void emitConnectedState() {
//     emit(state.copyWith(newStatus: NetworkStatus.connected));
//     // emit(copyWith(currentIndex, NetworkStatus.connected));
//   }

//   void emitDisconnectedState() {
//     emit(state.copyWith(index: currentIndex ,newStatus: NetworkStatus.disconnected));
//     // emit(DisconnectedState(selectedIndex: currentIndex));
//   }

//   @override
//   Future<void> close() {
//     connectivitySubscription.cancel();
//     return super.close();
//   }
// }

class MainCubit extends Cubit<MainState> {
  final Connectivity connectivity;
  late StreamSubscription connectivitySubscription;
  MainCubit(this.connectivity)
      : super(
            const MainState(selectedIndex: 0, status: NetworkStatus.loading)) {
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((resultType) {
      if (resultType == ConnectivityResult.wifi ||
          resultType == ConnectivityResult.mobile) {
        emitConnectedState();
      } else {
        emitDisconnectedState();
      }
    });
  }

  void selectedPage(int index) {
    emit(state.copyWith(index: index));
  }

  void emitConnectedState() {
    if (state.status == NetworkStatus.disconnected || state.status == NetworkStatus.loading) {
      emit(state.copyWith(newStatus: NetworkStatus.connected));
    }
  }

  void emitDisconnectedState() {
    if (state.status == NetworkStatus.connected || state.status == NetworkStatus.loading) {
      emit(state.copyWith(newStatus: NetworkStatus.disconnected));
    }
  }

  @override
  Future<void> close() {
    connectivitySubscription.cancel();
    return super.close();
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:welcome_task/constants/enums.dart';

class MainState extends Equatable {
  final int selectedIndex;
  final NetworkStatus status;

  const MainState({
    required this.selectedIndex,
    required this.status,
  });

  @override
  List<Object> get props => [selectedIndex, status];

  bool shouldRebuild(MainState oldState) {
    return oldState.selectedIndex != selectedIndex || oldState.status != status;
  }

  MainState copyWith({int? index, NetworkStatus? newStatus}) {
    return MainState(
      selectedIndex: index ?? selectedIndex,
      status: newStatus ?? status,
    );
  }
}

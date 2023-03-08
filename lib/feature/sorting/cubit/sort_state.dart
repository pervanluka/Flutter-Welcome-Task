part of 'sort_cubit.dart';

abstract class SortState extends Equatable {}

class SortInitial extends SortState {
  @override
  List<Object?> get props => [];
}

class SortReady extends SortState {
  final String timeTaken;

  SortReady(this.timeTaken);
  
  @override
  List<Object?> get props => [timeTaken];
}

class SortLoading extends SortState {
  @override
  List<Object?> get props => [];
}

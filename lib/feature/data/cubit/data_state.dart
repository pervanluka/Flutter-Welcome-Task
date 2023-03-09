import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:welcome_task/model/donut_model.dart';

@immutable
abstract class DataState extends Equatable {}

class DonutLoadingState extends DataState {
  @override
  List<Object?> get props => [];
}

class DonutLoadedState extends DataState {
  final List<DonutItem> donuts;
  DonutLoadedState(this.donuts);
  @override
  List<Object?> get props => [donuts];
}

class DonutErrorState extends DataState {
  final String error;
  DonutErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
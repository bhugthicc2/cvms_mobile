part of 'violation_cubit.dart';

abstract class ViolationState {}

class ViolationInitial extends ViolationState {}

class ViolationLoading extends ViolationState {}

class ViolationSuccess extends ViolationState {}

class ViolationError extends ViolationState {
  final String message;
  ViolationError(this.message);
}

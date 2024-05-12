part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  RegisterSuccess(this.msg);

  final String msg;
}

class RegisterFailure extends RegisterState {
  RegisterFailure(this.msg);

  final String msg;
}
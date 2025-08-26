import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import '../../../repositories/login/model/login_model.dart';

part 'login_bloc_state.g.dart';

@match
enum LoginStateStatus { initial, loading, error, success }

class LoginBlocState extends Equatable {
  final LoginModel? loginModel;
  final LoginStateStatus status;
  final String? errorMessage;
  final String? successMessage;

  const LoginBlocState({
    this.loginModel,
    required this.status,
    this.errorMessage,
    this.successMessage,
  });

  LoginBlocState.initial()
    : loginModel = LoginModel(),
      status = LoginStateStatus.initial,
      errorMessage = null,
      successMessage = null;

  @override
  List<Object?> get props => [loginModel, status, errorMessage, successMessage];

  LoginBlocState copyWith({
    LoginModel? loginModel,
    LoginStateStatus? status,
    String? errorMessage,
    String? successMessage,
  }) {
    return LoginBlocState(
      loginModel: loginModel ?? this.loginModel,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}

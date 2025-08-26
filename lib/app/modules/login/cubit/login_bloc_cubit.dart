import 'package:bloc/bloc.dart';

import '../../../repositories/login/login_repository.dart';
import 'login_bloc_state.dart';

class LoginBlocCubit extends Cubit<LoginBlocState> {
  final LoginRepository loginRepository;
  LoginBlocCubit({required this.loginRepository})
    : super(LoginBlocState.initial());

  Future<void> checkUrl() async {
    try {
      emit(state.copyWith(status: LoginStateStatus.loading));
      final loginValidation = await loginRepository.checkUrl();
    } on Exception {
      emit(
        state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: "Erro ao efetuar Login",
        ),
      );
    }
  }

  Future<void> login(String login, String password) async {
    try {

    } on Exception {
      emit(
        state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: "Erro ao efetuar Login",
        ),
      );
    }
  }
}

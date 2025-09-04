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

      await loginRepository.checkUrl();
    } catch (e) {
      emit(
        state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> login(String login, String password) async {
    try {
      emit(state.copyWith(status: LoginStateStatus.loading));

      final res = await loginRepository.login(login, password);
      if (res.validado == "T") {
        emit(
          state.copyWith(
            status: LoginStateStatus.success,
            loginModel: res,
            successMessage: "Login realizado com sucesso",
          ),
        );
      } else if (res.validado == "F") {
        emit(
          state.copyWith(
            status: LoginStateStatus.error,
            loginModel: res,
            errorMessage: "Usuário ou Senha incorreto !",
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

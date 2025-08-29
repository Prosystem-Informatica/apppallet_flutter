import 'package:apppallet_flutter/app/modules/load/cubit/load_bloc_state.dart';
import 'package:bloc/bloc.dart';

import '../../../repositories/load/load_repository.dart';
import '../../../repositories/login/login_repository.dart';

class LoadBlocCubit extends Cubit<LoadBlocState> {
  final LoadRepository loadRepository;
  LoadBlocCubit({required this.loadRepository})
    : super(LoadBlocState.initial());

  Future<void> checkPallet() async {
    try {
      emit(state.copyWith(status: LoadStateStatus.loading));

      var res = await loadRepository.loadData();
      if (res.id == '0') {
        emit(
          state.copyWith(
            roadModel: res,
            successMessage: 'Não há carga cadastrada',
            status: LoadStateStatus.success,
          ),
        );
      }
      print("Oq temos no cubit > ${res.id}");
      emit(state.copyWith(roadModel: res, status: LoadStateStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: LoadStateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> saveTravel(
    String idCarga,
    String entrega,
    String devolucao,
  ) async {
    try {
      emit(state.copyWith(status: LoadStateStatus.loading));

      final res = await loadRepository.sendData(idCarga, entrega, devolucao);
      emit(
        state.copyWith(
          status: LoadStateStatus.saved,
          successMessage: "Salvo com sucesso !!",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LoadStateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

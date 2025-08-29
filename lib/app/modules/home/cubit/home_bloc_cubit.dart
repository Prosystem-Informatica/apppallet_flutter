import 'package:bloc/bloc.dart';
import '../../../repositories/home/home_repository.dart';
import 'home_bloc_state.dart';

class HomeBlocCubit extends Cubit<HomeBlocState> {
  final HomeRepository homeRepository;
  HomeBlocCubit({required this.homeRepository})
    : super(HomeBlocState.initial());

  Future<void> checkPallet() async {
    try {
      emit(state.copyWith(status: HomeStateStatus.loading));

      var res = await homeRepository.loadData();
      print("Cubit > ${res.id}");
      if (res.id == '0' || res.id == null) {
        emit(
          state.copyWith(
            roadModel: res,
            successMessage: 'Não há carga cadastrada',
            status: HomeStateStatus.success,

          ),
        );
      }
      if (res.id != '0' || res.id != null) {
        print("Oq temos no cubit > ${res.id}");
        emit(state.copyWith(roadModel: res, status: HomeStateStatus.hasWork));
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> fetchDashboard() async {
    emit(state.copyWith(status: HomeStateStatus.loading));
    try {
      final data = await homeRepository.fetchDashboard();
      emit(state.copyWith(status: HomeStateStatus.success, travelModel: data));
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

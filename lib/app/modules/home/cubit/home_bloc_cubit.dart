import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import '../../../repositories/home_repository.dart';

part 'home_bloc_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;
  HomeCubit(this.repository) : super(HomeState.initial());

  Future<void> fetchDashboard() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final data = await repository.fetchDashboard();
      emit(state.copyWith(
        status: HomeStatus.success,
        dashboard: data,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
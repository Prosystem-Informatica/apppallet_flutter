import 'package:bloc/bloc.dart';
import '../../../repositories/home/home_repository.dart';
import 'home_bloc_state.dart';

class HomeBlocCubit extends Cubit<HomeBlocState> {
  final HomeRepository homeRepository;
  HomeBlocCubit({required this.homeRepository})
    : super(HomeBlocState.initial());

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

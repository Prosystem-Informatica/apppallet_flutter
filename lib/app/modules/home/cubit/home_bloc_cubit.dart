import 'package:apppallet_flutter/app/repositories/home/home_repository.dart';
import 'package:bloc/bloc.dart';

import 'home_bloc_state.dart';


class HomeBlocCubit extends Cubit<HomeBlocState> {
  final HomeRepository homeRepository;
  HomeBlocCubit({required this.homeRepository})
      : super(HomeBlocState.initial());

  Future<void> checkUrl() async {
    try {
      emit(state.copyWith(status: HomeStateStatus.loading));

      await homeRepository.checkUrl();
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

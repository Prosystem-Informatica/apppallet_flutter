import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import '../../../repositories/home/model/home_model.dart';

part 'home_bloc_state.g.dart';

@match
enum HomeStateStatus { initial, loading, error, success }

class HomeBlocState extends Equatable {
  final HomeModel? homeModel;
  final HomeStateStatus status;
  final String? errorMessage;
  final String? successMessage;

  const HomeBlocState({
    this.homeModel,
    required this.status,
    this.errorMessage,
    this.successMessage,
  });

  HomeBlocState.initial()
      : homeModel = HomeModel(),
        status = HomeStateStatus.initial,
        errorMessage = null,
        successMessage = null;

  @override
  List<Object?> get props => [homeModel, status, errorMessage, successMessage];

  HomeBlocState copyWith({
    HomeModel? homeModel,
    HomeStateStatus? status,
    String? errorMessage,
    String? successMessage,
  }) {
    return HomeBlocState(
      homeModel: homeModel ?? this.homeModel,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}

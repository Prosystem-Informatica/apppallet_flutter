import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import '../../../repositories/home/model/travel_model.dart';
import '../../../repositories/login/model/login_model.dart';

part 'home_bloc_state.g.dart';

@match
enum HomeStateStatus { initial, loading, error, success }

class HomeBlocState extends Equatable {
  final TravelModel? travelModel;
  final HomeStateStatus status;
  final String? errorMessage;
  final String? successMessage;

  const HomeBlocState({
    this.travelModel,
    required this.status,
    this.errorMessage,
    this.successMessage,
  });

  HomeBlocState.initial()
    : travelModel = TravelModel(),
      status = HomeStateStatus.initial,
      errorMessage = null,
      successMessage = null;

  @override
  List<Object?> get props => [
    travelModel,
    status,
    errorMessage,
    successMessage,
  ];

  HomeBlocState copyWith({
    TravelModel? travelModel,
    HomeStateStatus? status,
    String? errorMessage,
    String? successMessage,
  }) {
    return HomeBlocState(
      travelModel: travelModel ?? this.travelModel,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}

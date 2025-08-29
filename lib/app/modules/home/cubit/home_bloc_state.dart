import 'package:apppallet_flutter/app/repositories/load/model/road_model.dart';
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import '../../../repositories/home/model/travel_model.dart';
import '../../../repositories/login/model/login_model.dart';

part 'home_bloc_state.g.dart';

@match
enum HomeStateStatus { initial, loading, error, success, hasWork }

class HomeBlocState extends Equatable {
  final TravelModel? travelModel;
  final RoadModel? roadModel;
  final HomeStateStatus status;
  final String? errorMessage;
  final String? successMessage;

  const HomeBlocState({
    this.travelModel,
    this.roadModel,
    required this.status,
    this.errorMessage,
    this.successMessage,
  });

  HomeBlocState.initial()
    : travelModel = TravelModel(),
      roadModel = RoadModel(),
      status = HomeStateStatus.initial,
      errorMessage = null,
      successMessage = null;

  @override
  List<Object?> get props => [
    travelModel,
    roadModel,
    status,
    errorMessage,
    successMessage,
  ];

  HomeBlocState copyWith({
    TravelModel? travelModel,
    RoadModel? roadModel,
    HomeStateStatus? status,
    String? errorMessage,
    String? successMessage,
  }) {
    return HomeBlocState(
      travelModel: travelModel ?? this.travelModel,
      roadModel: roadModel ?? this.roadModel,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}

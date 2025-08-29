import 'package:apppallet_flutter/app/repositories/load/model/road_model.dart';
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import '../../../repositories/login/model/login_model.dart';

part 'load_bloc_state.g.dart';

@match
enum LoadStateStatus { initial, loading, error, success, saved }

class LoadBlocState extends Equatable {
  final RoadModel? roadModel;
  final LoadStateStatus status;
  final String? errorMessage;
  final String? successMessage;

  const LoadBlocState({
    this.roadModel,
    required this.status,
    this.errorMessage,
    this.successMessage,
  });

  LoadBlocState.initial()
    : roadModel = RoadModel(),
      status = LoadStateStatus.initial,
      errorMessage = null,
      successMessage = null;

  @override
  List<Object?> get props => [roadModel, status, errorMessage, successMessage];

  LoadBlocState copyWith({
    RoadModel? roadModel,
    LoadStateStatus? status,
    String? errorMessage,
    String? successMessage,
  }) {
    return LoadBlocState(
      roadModel: roadModel ?? this.roadModel,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}

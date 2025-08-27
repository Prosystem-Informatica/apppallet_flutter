part of 'home_bloc_cubit.dart';

enum HomeStatus { initial, loading, success, error }

class DashboardModel extends Equatable {
  final String totalViagens;
  final String viagensNormal;
  final String viagensExtra;
  final String totalDev;

  const DashboardModel({
    required this.totalViagens,
    required this.viagensNormal,
    required this.viagensExtra,
    required this.totalDev,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      totalViagens: json['TOTAL_VIAGENS'].toString(),
      viagensNormal: json['VIAGENS_NORMAL'].toString(),
      viagensExtra: json['VIAGENS_EXTRA'].toString(),
      totalDev: json['TOTAL_DEV'].toString(),
    );
  }

  @override
  List<Object?> get props => [totalViagens, viagensNormal, viagensExtra, totalDev];
}

class HomeState extends Equatable {
  final HomeStatus status;
  final DashboardModel? dashboard;
  final String? errorMessage;

  const HomeState({
    required this.status,
    this.dashboard,
    this.errorMessage,
  });

  factory HomeState.initial() => const HomeState(status: HomeStatus.initial);

  HomeState copyWith({
    HomeStatus? status,
    DashboardModel? dashboard,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      dashboard: dashboard ?? this.dashboard,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, dashboard, errorMessage];
}
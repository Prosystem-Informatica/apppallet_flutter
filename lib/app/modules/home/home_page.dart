import 'dart:async';

import 'package:apppallet_flutter/app/modules/home/widget/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../core/ui/helpers/messages.dart';
import 'cubit/home_bloc_cubit.dart';
import '../../repositories/home/home_repository.dart';
import 'cubit/home_bloc_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Messages<HomePage> {
  late var travelModel;
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<HomeBlocCubit>(context).fetchDashboard();

    super.initState();
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer(const Duration(seconds: 30), () {
      BlocProvider.of<HomeBlocCubit>(context).checkPallet();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBlocCubit, HomeBlocState>(
      listener: (context, state) {
        state.status.matchAny(
          success: () async {
            travelModel = state.travelModel;

            _startTimer();
          },
          error: () {
            showError(state.errorMessage ?? "Erro não informado");
          },
          any: () {},
          hasWork: () {
            state.roadModel!.id == "0"
                ? null
                : showSuccess("Existe uma carga pendente !!");
            BlocProvider.of<HomeBlocCubit>(context).fetchDashboard();
          },
        );
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state.status == HomeStateStatus.loading) {
          return Scaffold(
            appBar: AppBar(title: const Text("Home")),
            body: Container(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }
        if (state.status == HomeStateStatus.success) {
          return Scaffold(
            appBar: AppBar(title: const Text("Home")),
            body: BlocBuilder<HomeBlocCubit, HomeBlocState>(
              builder: (context, state) {
                if (state.status == HomeStateStatus.loading) {
                  return Container(
                    color: Colors.white,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                } else if (state.status == HomeStateStatus.error) {
                  return Container(
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        state.errorMessage ??
                            "Ocorreu um erro ao carregar os dados.",
                      ),
                    ),
                  );
                } else if (state.status == HomeStateStatus.success &&
                    travelModel != null) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: [
                        buildDashboardCard(
                          context: context,
                          title: "Total Viagens",
                          value: travelModel.totalViagens ?? "-",
                          icon: Icons.directions_bus,
                        ),
                        buildDashboardCard(
                          context: context,
                          title: "Normais",
                          value: travelModel.viagensNormal ?? "-",
                          icon: Icons.check_circle_outline,
                        ),
                        buildDashboardCard(
                          context: context,
                          title: "Extras",
                          value: travelModel.viagensExtra ?? "-",
                          icon: Icons.add_circle_outline,
                        ),
                        buildDashboardCard(
                          context: context,
                          title: "Devoluções",
                          value: travelModel.totalDev ?? "-",
                          icon: Icons.undo,
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: Text("Nenhum dado para exibir."));
                }
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.toNamed('/load');
              },
              child: const Icon(Icons.fire_truck_outlined),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(title: const Text("Home")),
          body: Container(
            color: Colors.white,
            child: Center(child: Text("Nenhum dado para exibir.")),
          ),
        );
      },
    );
  }
}

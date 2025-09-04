import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/ui/helpers/messages.dart';
import 'cubit/home_bloc_cubit.dart';
import 'cubit/home_bloc_state.dart';
import 'widget/card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Messages<HomePage> {
  late var travelModel;
  Timer? _timer;
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    BlocProvider.of<HomeBlocCubit>(context).fetchDashboard();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString("login") ?? '';
    });
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

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
            if (state.roadModel?.id != '0') {
              showSuccess('Existe uma carga pendente !!');
              Get.toNamed('/load');
            }
            BlocProvider.of<HomeBlocCubit>(context).fetchDashboard();
          },
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Home"),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: _logout,
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_username != null && _username!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Bem-vindo, $_username",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary),
                  ),
                ),
              Expanded(
                child: BlocBuilder<HomeBlocCubit, HomeBlocState>(
                  builder: (context, state) {
                    if (state.status == HomeStateStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.status == HomeStateStatus.error) {
                      return Center(
                        child: Text(
                          state.errorMessage ??
                              "Ocorreu um erro ao carregar os dados.",
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
                              value: travelModel.totalViagens ?? "0",
                              icon: Icons.directions_bus,
                            ),
                            buildDashboardCard(
                              context: context,
                              title: "Normais",
                              value: travelModel.viagensNormal ?? "0",
                              icon: Icons.check_circle_outline,
                            ),
                            buildDashboardCard(
                              context: context,
                              title: "Extras",
                              value: travelModel.viagensExtra ?? "0",
                              icon: Icons.add_circle_outline,
                            ),
                            buildDashboardCard(
                              context: context,
                              title: "Devoluções",
                              value: travelModel.totalDev ?? "0",
                              icon: Icons.undo,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                          child: Text("Nenhum dado para exibir."));
                    }
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed('/load');
            },
            child: const Icon(Icons.fire_truck_outlined),
          ),
        );
      },
    );
  }
}

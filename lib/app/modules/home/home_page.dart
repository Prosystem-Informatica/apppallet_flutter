import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'cubit/home_bloc_cubit.dart';
import '../../repositories/home/home_repository.dart';
import 'cubit/home_bloc_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _buildDashboardCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: colorScheme.primary),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              HomeBlocCubit(homeRepository: HomeRepository())..fetchDashboard(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Home")),
        body: BlocBuilder<HomeBlocCubit, HomeBlocState>(
          builder: (context, state) {
            if (state.status == HomeStateStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == HomeStateStatus.error) {
              return Center(
                child: Text(
                  state.errorMessage ?? "Ocorreu um erro ao carregar os dados.",
                ),
              );
            } else if (state.status == HomeStateStatus.success &&
                state.travelModel != null) {
              final dashboardData = state.travelModel!;
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    _buildDashboardCard(
                      title: "Total Viagens",
                      value: dashboardData.totalViagens ?? "-",
                      icon: Icons.directions_bus,
                    ),
                    _buildDashboardCard(
                      title: "Normais",
                      value: dashboardData.viagensNormal ?? "-",
                      icon: Icons.check_circle_outline,
                    ),
                    _buildDashboardCard(
                      title: "Extras",
                      value: dashboardData.viagensExtra ?? "-",
                      icon: Icons.add_circle_outline,
                    ),
                    _buildDashboardCard(
                      title: "Devoluções",
                      value: dashboardData.totalDev ?? "-",
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
      ),
    );
  }
}

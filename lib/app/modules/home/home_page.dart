import 'package:flutter/material.dart';

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

    final ColorScheme colorScheme = Theme
        .of(context)
        .colorScheme;

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
                // O texto do valor também usa a cor primária do tema
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              // Opcional: você pode definir a cor do título usando o colorScheme também
              // style: TextStyle(fontSize: 16, color: colorScheme.onSurfaceVariant),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _buildDashboardCard(
              title: "Total Viagens",
              value: "120",
              icon: Icons.directions_bus,
            ),
            _buildDashboardCard(
              title: "Normais",
              value: "80",
              icon: Icons.check_circle_outline,
            ),
            _buildDashboardCard(
              title: "Extras",
              value: "25",
              icon: Icons.add_circle_outline,
            ),
            _buildDashboardCard(
              title: "Devoluções",
              value: "15",
              icon: Icons.undo,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.fire_truck_outlined),
      ),
    );
  }
}
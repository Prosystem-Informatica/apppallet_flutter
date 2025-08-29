import 'package:flutter/material.dart';

Widget buildDashboardCard({
  required BuildContext context,
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Column(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/load');
        },
        child: Icon(Icons.fire_truck_outlined),
      ),
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../modules/home/cubit/home_bloc_cubit.dart';

class HomeRepository {
  Future<DashboardModel> fetchDashboard() async {
    final url = 'http://prosystem02.dyndns-work.com:8081/datasnap/rest/TServerAPPnfe/Viagens_Dev/1/14';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return DashboardModel.fromJson(jsonData);
    } else {
      throw Exception('Erro ao buscar dados do dashboard');
    }
  }
}
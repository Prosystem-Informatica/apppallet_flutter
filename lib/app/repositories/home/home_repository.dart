import 'dart:convert';
import 'package:apppallet_flutter/app/repositories/home/model/travel_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/home/cubit/home_bloc_cubit.dart';

class HomeRepository {
  late SharedPreferences prefs;

  Future<TravelModel> fetchDashboard() async {
    try {
      prefs = await SharedPreferences.getInstance();
      var codigo = await prefs.getString("codigo");
      var empresa = await prefs.getString("empresa");
      var host = await prefs.getString("host");
      var port = await prefs.getString("port");
      final url =
          'http://$host:$port/datasnap/rest/TServerAPPnfe/Viagens_Dev/$empresa/$codigo';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return TravelModel.fromJson(jsonData);
      } else {
        throw Exception('Erro ao buscar dados do dashboard');
      }
    } catch (e) {
      return TravelModel();
    }
  }
}

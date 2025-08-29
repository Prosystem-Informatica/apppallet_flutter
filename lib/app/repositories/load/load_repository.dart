import 'dart:convert';
import 'package:apppallet_flutter/app/repositories/home/model/travel_model.dart';
import 'package:apppallet_flutter/app/repositories/load/model/road_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/home/cubit/home_bloc_cubit.dart';

class LoadRepository {
  late SharedPreferences prefs;

  Future<RoadModel> loadData() async {
    try {
      prefs = await SharedPreferences.getInstance();
      var host = await prefs.getString("host");
      var port = await prefs.getString("port");
      var codigo = await prefs.getString("codigo");
      var empresa = await prefs.getString("empresa");
      final url =
          'http://$host:$port/datasnap/rest/TServerAPPnfe/VerificaCarga/$empresa/$codigo';
      final response = await http.get(Uri.parse(url));
      print("RESPONSE > ${response.body}");
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print("Oq tem no JSON > ${jsonData}");
        var res = RoadModel.fromJson(jsonData[0]);
        print("Oq tem no RES > ${res.id}");
        return res;
      } else {
        throw Exception('Erro ao buscar dados da carga');
      }
    } catch (e) {
      return RoadModel();
    }
  }

  Future<TravelModel> sendData(
    String idCarga,
    String entrega,
    String devolucao,
  ) async {
    try {
      prefs = await SharedPreferences.getInstance();
      var host = await prefs.getString("host");
      var port = await prefs.getString("port");
      final url =
          'http://$host:$port/datasnap/rest/TServerAPPnfe/GravaPaletes/$idCarga/$entrega/$devolucao';
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

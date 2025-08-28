import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/rest/rest_client.dart';
import 'i_home_repository.dart';
import 'model/home_model.dart';

class HomeRepository implements IHomeRepository {
  final RestClient _rest;
  late SharedPreferences prefs;
  HomeRepository({required RestClient rest}) : _rest = rest;

  @override
  Future<void> checkUrl() async {
    try {
      prefs = await SharedPreferences.getInstance();
      var url =
          'http://prosystem.dyndns-work.com:9090/datasnap/rest/TserverAPPnfe/LoginEmpresa/09334805000146';

      var response = await http.get(Uri.parse(url));

      var jsonData = jsonDecode(response.body);
      print("Json > ${jsonData}");

      await prefs.setString(
        'empresa',
        jsonData[0]['EMPRESA'].toString().toLowerCase(),
      );
      await prefs.setString(
        'codigo',
        jsonData[0]['CODIGO'].toString().toLowerCase(),
      );

      return jsonData;
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<HomeModel> home(String totalViagens, String totalNormal, String totalExtra, String totalDev) async {
    try {
      prefs = await SharedPreferences.getInstance();
      var empresa = await prefs.getString("empresa");
     var codigo = await prefs.getString("codigo");
      var url =
          'http://prosystem02.dyndns-work.com:8081/datasnap/rest/TServerAPPnfe/Viagens_Dev/$empresa/$codigo';
      var response = await http.get(Uri.parse(url));

      var jsonData = jsonDecode(response.body);
      print("Json > ${jsonData}");

      var res = await HomeModel.fromJson(jsonData[0]);

      return res;
    } catch (e) {
      log(e.toString());
      return HomeModel();

    }
  }
}

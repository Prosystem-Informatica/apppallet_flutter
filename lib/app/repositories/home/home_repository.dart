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
        'host',
        jsonData[0]['SERVIDOR'].toString().toLowerCase(),
      );
      await prefs.setString(
        'port',
        jsonData[0]['PORTA'].toString().toLowerCase(),
      );

      return jsonData;
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<HomeModel> home(String totalviagens, String totalnormal, String totalextra, String totaldev)  async {
    try {
      prefs = await SharedPreferences.getInstance();
      var host = await prefs.getString("host");
      var port = await prefs.getString("port");
      var url =
          'http://$host:$port/datasnap/rest/TserverAPPnfe/LoginPalete/$totalviagens/$totalnormal/$totalextra/$totaldev';

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
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/rest/rest_client.dart';
import 'i_login_repository.dart';
import 'model/login_model.dart';

class LoginRepository implements ILoginRepository {
  final RestClient _rest;
  late SharedPreferences prefs;

  LoginRepository({required RestClient rest}) : _rest = rest;

  @override
  Future<void> checkUrl() async {
    try {
      prefs = await SharedPreferences.getInstance();
      var url =
          'http://prosystem.dyndns-work.com:9090/datasnap/rest/TserverAPPnfe/LoginEmpresa/09334805000146';

      var response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception("Erro ao buscar URL: ${response.statusCode}");
      }

      var jsonData = jsonDecode(response.body);
      print("Json do check> $jsonData");

      if (jsonData is List && jsonData.isNotEmpty) {
        await prefs.setString(
          'host',
          jsonData[0]['SERVIDOR']?.toString().toLowerCase() ?? '',
        );
        await prefs.setString(
          'port',
          jsonData[0]['PORTA']?.toString().toLowerCase() ?? '',
        );
      } else {
        throw Exception("Resposta inválida do checkUrl");
      }
    } catch (e) {
      log("Erro checkUrl: $e");
      rethrow;
    }
  }

  @override
  Future<LoginModel> login(String login, String password) async {
    try {
      prefs = await SharedPreferences.getInstance();

      var host = prefs.getString("host");
      var port = prefs.getString("port");

      if (host == null || port == null || host.isEmpty || port.isEmpty) {
        throw Exception("Host ou porta não configurados");
      }

      var url =
          'http://$host:$port/datasnap/rest/TserverAPPnfe/LoginPalete/$login/$password';
      var response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        throw Exception("Erro no login: ${response.statusCode}");
      }

      var jsonData = jsonDecode(response.body);
      print("Json do login > $jsonData");

      if (jsonData is! List || jsonData.isEmpty) {
        throw Exception("Login ou senha invalidos");
      }

      final data = jsonData[0];

      if (data['VALIDADO'] != 'T') {
        throw Exception("Login ou senha invalidos");
      }

      await prefs.setString('codigo', data['CODIGO']?.toString() ?? '');
      await prefs.setString('empresa', data['EMPRESA']?.toString() ?? '');
      await prefs.setString("login", login);
      await prefs.setBool("isLogged", true);

      return LoginModel.fromJson(data);
    } catch (e) {
      log("Erro login: $e");
      rethrow;

    }
  }
}

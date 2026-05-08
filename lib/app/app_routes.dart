import 'package:apppallet_flutter/app/modules/home/home_page.dart';
import 'package:apppallet_flutter/app/modules/load/load_page.dart';
import 'package:get/get.dart';
import 'modules/login/login_page.dart';
import 'modules/splash_page.dart';

class Routes {
  static const INITIAL = "/splash";
  static const LOGIN = "/login";
  static const HOME = "/home";
  static const LOAD = "/load";
}

class AppPages {
  static final pages = [
    GetPage(name: Routes.INITIAL, page: () => const SplashPage()),
    GetPage(name: Routes.LOGIN, page: () => const LoginPage()),
    GetPage(name: Routes.HOME, page: () => const HomePage()),
    GetPage(name: Routes.LOAD, page: () => const LoadPage()),
  ];
}

import 'package:get/get.dart';

import 'modules/login/login_page.dart';

class Routes {
  static const INITIAL = "/login";
}

class AppPages {
  static final pages = [
    GetPage(name: Routes.INITIAL, page: () => const LoginPage()),
  ];
}

import 'package:b201_app/presentation/page/home_page/home_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String home = '/';
}

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.home, page: () => const HomePage()),
  ];
}

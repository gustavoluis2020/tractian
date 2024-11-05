import 'package:get/get.dart';
import 'package:tractian_assets/core/routes/app_routes.dart';
import 'package:tractian_assets/src/home/presentation/bindings/home_bindings.dart';
import 'package:tractian_assets/src/home/presentation/views/home_page.dart';
import 'package:tractian_assets/src/assets/presentation/bindings/assets_bindings.dart';
import 'package:tractian_assets/src/assets/presentation/view/assets_page.dart';

class AppPages {
  List<GetPage> get routes => [
        GetPage(
          name: Routes.home,
          page: () => const HomePage(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: Routes.assets,
          page: () => const AssetsPage(),
          binding: AssetsBinding(),
        ),
      ];
}

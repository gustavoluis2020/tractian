import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_assets/core/constants/app_colors.dart';
import 'package:tractian_assets/core/routes/app_pages.dart';
import 'package:tractian_assets/core/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tractian Assets',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.white,
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      getPages: AppPages().routes,
      initialRoute: Routes.home,
    );
  }
}

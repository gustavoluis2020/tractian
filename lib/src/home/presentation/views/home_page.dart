import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tractian_assets/core/constants/app_assets.dart';
import 'package:tractian_assets/core/constants/app_colors.dart';
import 'package:tractian_assets/core/routes/app_routes.dart';
import 'package:tractian_assets/src/home/presentation/controllers/home_controller.dart';
import 'package:tractian_assets/src/home/presentation/views/widgets/button_home_companies.dart';
import 'package:tractian_assets/src/home/presentation/views/widgets/button_home_shimmer.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.black,
        title: SvgPicture.asset(
          AppAssets.logo,
          width: 126,
          height: 17,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const ButtonHomeShimmer(index: 3);
        }
        if (controller.companies.isEmpty) {
          return const Center(
            child: Text('Nenhuma empresa disponível'),
          );
        }
        return ListView.builder(
          itemCount: controller.companies.length,
          itemBuilder: (context, index) {
            final company = controller.companies[index];
            return ButtonHomeCompanies(
              nameCompany: company.name,
              onTap: () {
                Get.toNamed(
                  Routes.assets,
                  arguments: {'companyId': company.id},
                );
              },
            );
          },
        );
      }),
    );
  }
}

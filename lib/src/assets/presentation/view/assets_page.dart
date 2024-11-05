import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_assets/core/constants/app_assets.dart';
import 'package:tractian_assets/core/constants/app_colors.dart';
import 'package:tractian_assets/src/assets/presentation/controller/assets_controller.dart';
import 'package:tractian_assets/src/assets/presentation/view/widgets/asset_shimmer_widget.dart';
import 'package:tractian_assets/src/assets/presentation/view/widgets/button_filters_widget.dart';
import 'package:tractian_assets/src/assets/presentation/view/widgets/text_search_field_widget.dart';
import 'package:tractian_assets/src/assets/presentation/view/widgets/tree_view_widget.dart';

class AssetsPage extends GetView<AssetsController> {
  const AssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.black,
          title: const Text(
            'Assets',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: AppColors.white,
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextSearchFieldWidget(
                hintText: 'Buscar Ativo ou Local',
                onChanged: (value) {
                  controller.filterListFromText(value);
                },
              ),
            ),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Row(
                  children: [
                    ButtonFiltersWidget(
                      svgPath: AppAssets.bolt,
                      text: 'Sensor de Energia',
                      isActive: controller.isButtonActiveEnergy.value,
                      onPressed: () {
                        controller.toggleButtonEnergy();
                      },
                    ),
                    const SizedBox(width: 8),
                    ButtonFiltersWidget(
                      svgPath: AppAssets.info,
                      text: 'Crítico',
                      isActive: controller.isButtonActiveCritical.value,
                      onPressed: () {
                        controller.toggleButtonCritical();
                      },
                    ),
                  ],
                ),
              );
            }),
            const Divider(
              height: 1.0,
              thickness: 1.0,
              color: AppColors.greyDivider,
            ),
            const SizedBox(height: 4),
            Obx(
              () {
                if (controller.isLoading.value) {
                  return const AssetShimmerWidget(
                    index: 10,
                  );
                }
                if (controller.nodesListFiltered.isEmpty) {
                  return const Center(
                    child: Text('Nenhuma compania disponível'),
                  );
                }
                return GetBuilder<AssetsController>(
                  builder: (context) {
                    return TreeViewWidget(
                      nodes: controller.nodesListFiltered,
                      expandedNodes: controller.expandedNodes,
                      onNodeTapped: (node) {
                        controller.toggleExpansion(node);
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_assets/core/helpers/use_case.dart';
import 'package:tractian_assets/src/home/domain/entities/company_entity.dart';
import 'package:tractian_assets/src/home/domain/usecases/get_companies.dart';

class HomeController extends GetxController {
  RxList<CompanyEntity> companies = <CompanyEntity>[].obs;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCompanies();
  }

  Future<void> getCompanies() async {
    isLoading.value = true;
    GetCompanies getCompanies = Get.find();
    final result = await getCompanies(NoParams());
    result.fold((l) {
      debugPrint(l.toString());
      isLoading.value = false;
    }, (r) {
      companies.value = r;
      isLoading.value = false;
    });
  }
}

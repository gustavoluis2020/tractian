import 'package:get/get.dart';
import 'package:tractian_assets/src/assets/data/data_sources/assets_data_source_impl.dart';
import 'package:tractian_assets/src/assets/data/repository_impl/assets_repository_impl.dart';
import 'package:tractian_assets/src/assets/domain/repositories/assets_repository.dart';
import 'package:tractian_assets/src/assets/domain/usecases/get_assets_by_company.dart';
import 'package:tractian_assets/src/assets/domain/usecases/get_locations_by_company.dart';
import 'package:tractian_assets/src/assets/presentation/controller/assets_controller.dart';
import 'package:http/http.dart' as http;

class AssetsBinding implements Bindings {
  @override
  void dependencies() {
    final client = http.Client();

    final AssetsRepository homeDetailsRepo = AssetsRepositoryImpl(
      remoteDatasource: AssetsDataSourceImpl(client: client),
    );
    Get.lazyPut<GetAssetsByCompany>(() => GetAssetsByCompany(homeDetailsRepo), fenix: true);

    Get.lazyPut<GetLocationsByCompany>(() => GetLocationsByCompany(homeDetailsRepo), fenix: true);

    Get.lazyPut<AssetsController>(() => AssetsController());
  }
}

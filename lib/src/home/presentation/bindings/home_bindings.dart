import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:tractian_assets/src/home/data/data_sources/home_data_source_impl.dart';
import 'package:tractian_assets/src/home/data/repository_impl/home_repository_impl.dart';
import 'package:tractian_assets/src/home/domain/repositories/home_repository.dart';
import 'package:tractian_assets/src/home/domain/usecases/get_companies.dart';
import 'package:tractian_assets/src/home/presentation/controllers/home_controller.dart';

class HomeBinding implements Bindings {
  final client = http.Client();

  @override
  void dependencies() {
    final HomeRepository homeRepo = HomeRepositoryImpl(
      remoteDatasource: HomeDataSourceImpl(client: client),
    );
    Get.lazyPut<GetCompanies>(() => GetCompanies(homeRepo), fenix: true);

    Get.lazyPut<HomeController>(() => HomeController());
  }
}

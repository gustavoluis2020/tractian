import 'package:tractian_assets/src/home/data/models/company_model.dart';

abstract class HomeDataSource {
  Future<List<CompanyModel>> getCompanies();
}

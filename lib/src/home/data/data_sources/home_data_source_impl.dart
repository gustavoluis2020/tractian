import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tractian_assets/src/home/data/data_sources/home_data_source.dart';
import 'package:tractian_assets/src/home/data/errors/exeptions.dart';
import 'package:tractian_assets/src/home/data/models/company_model.dart';

class HomeDataSourceImpl implements HomeDataSource {
  final http.Client client;

  HomeDataSourceImpl({required this.client});

  @override
  Future<List<CompanyModel>> getCompanies() async {
    try {
      final response = await client.get(Uri.parse('https://fake-api.tractian.com/companies'));

      if (response.statusCode == 200) {
        final List decodedJson = json.decode(response.body);
        return decodedJson.map((company) => CompanyModel.fromJson(company)).toList();
      } else {
        throw GetCompanyException('Error to get companies');
      }
    } catch (e) {
      throw GetCompanyException(e.toString());
    }
  }
}

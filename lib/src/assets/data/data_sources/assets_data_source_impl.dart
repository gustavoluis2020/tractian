import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tractian_assets/src/assets/data/data_sources/assets_data_source.dart';
import 'package:tractian_assets/src/assets/data/errors/exeptions.dart';
import 'package:tractian_assets/src/assets/data/models/asset_model.dart';
import 'package:tractian_assets/src/assets/data/models/location_model.dart';

class AssetsDataSourceImpl implements AssetsDataSource {
  final http.Client client;

  AssetsDataSourceImpl({required this.client});

  @override
  Future<List<LocationModel>> getLocationsByCompany(String companyId) async {
    try {
      final response = await client.get(Uri.parse('https://fake-api.tractian.com/companies/$companyId/locations'));

      if (response.statusCode == 200) {
        final List decodedJson = json.decode(response.body);
        return decodedJson.map((location) => LocationModel.fromJson(location)).toList();
      } else {
        throw GetLocationException('Error to get locations');
      }
    } catch (e) {
      throw GetLocationException(e.toString());
    }
  }

  @override
  Future<List<AssetModel>> getAssetsByCompany(String companyId) async {
    try {
      final response = await client.get(Uri.parse('https://fake-api.tractian.com/companies/$companyId/assets'));

      if (response.statusCode == 200) {
        final List decodedJson = json.decode(response.body);
        return decodedJson.map((asset) => AssetModel.fromJson(asset)).toList();
      } else {
        throw GetAssetException('Error to get assets');
      }
    } catch (e) {
      throw GetAssetException(e.toString());
    }
  }
}

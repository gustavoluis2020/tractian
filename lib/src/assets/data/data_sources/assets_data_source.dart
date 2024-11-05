import 'package:tractian_assets/src/assets/data/models/asset_model.dart';
import 'package:tractian_assets/src/assets/data/models/location_model.dart';

abstract class AssetsDataSource {
  Future<List<AssetModel>> getAssetsByCompany(String companyId);
  Future<List<LocationModel>> getLocationsByCompany(String companyId);
}

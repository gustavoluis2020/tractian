import 'package:dartz/dartz.dart';
import 'package:tractian_assets/core/failure/failure.dart';
import 'package:tractian_assets/src/assets/domain/entities/asset_entity.dart';
import 'package:tractian_assets/src/assets/domain/entities/location_entity.dart';

abstract class AssetsRepository {
  Future<Either<Failure, List<LocationEntity>>> getLocationsByCompany(String companyId);
  Future<Either<Failure, List<AssetEntity>>> getAssetsByCompany(String companyId);
}

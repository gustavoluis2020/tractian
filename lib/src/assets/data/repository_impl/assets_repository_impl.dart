import 'package:dartz/dartz.dart';
import 'package:tractian_assets/core/failure/failure.dart';
import 'package:tractian_assets/src/assets/data/data_sources/assets_data_source.dart';
import 'package:tractian_assets/src/assets/data/errors/exeptions.dart';
import 'package:tractian_assets/src/assets/domain/entities/asset_entity.dart';
import 'package:tractian_assets/src/assets/domain/entities/location_entity.dart';
import 'package:tractian_assets/src/assets/domain/repositories/assets_repository.dart';

class AssetsRepositoryImpl implements AssetsRepository {
  final AssetsDataSource remoteDatasource;

  AssetsRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, List<AssetEntity>>> getAssetsByCompany(String companyId) async {
    try {
      final assets = await remoteDatasource.getAssetsByCompany(companyId);
      return Right(assets);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(GetAssetException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LocationEntity>>> getLocationsByCompany(String companyId) async {
    try {
      final locations = await remoteDatasource.getLocationsByCompany(companyId);
      return Right(locations);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(GetLocationException(e.toString()));
    }
  }
}

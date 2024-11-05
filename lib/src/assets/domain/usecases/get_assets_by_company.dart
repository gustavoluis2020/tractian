import 'package:dartz/dartz.dart';
import 'package:tractian_assets/core/failure/failure.dart';
import 'package:tractian_assets/core/helpers/use_case.dart';
import 'package:tractian_assets/src/assets/domain/entities/asset_entity.dart';
import 'package:tractian_assets/src/assets/domain/repositories/assets_repository.dart';

class GetAssetsByCompany extends UseCase<List<AssetEntity>, String> {
  final AssetsRepository repository;

  GetAssetsByCompany(this.repository);

  @override
  Future<Either<Failure, List<AssetEntity>>> call(String params) async {
    return await repository.getAssetsByCompany(params);
  }
}

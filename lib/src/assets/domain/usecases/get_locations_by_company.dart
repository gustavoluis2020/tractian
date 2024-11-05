import 'package:dartz/dartz.dart';
import 'package:tractian_assets/core/failure/failure.dart';
import 'package:tractian_assets/core/helpers/use_case.dart';
import 'package:tractian_assets/src/assets/domain/entities/location_entity.dart';
import 'package:tractian_assets/src/assets/domain/repositories/assets_repository.dart';

class GetLocationsByCompany extends UseCase<List<LocationEntity>, String> {
  final AssetsRepository repository;

  GetLocationsByCompany(this.repository);

  @override
  Future<Either<Failure, List<LocationEntity>>> call(String params) async {
    return await repository.getLocationsByCompany(params);
  }
}

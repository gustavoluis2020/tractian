import 'package:dartz/dartz.dart';
import 'package:tractian_assets/core/failure/failure.dart';
import 'package:tractian_assets/src/home/domain/entities/company_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<CompanyEntity>>> getCompanies();
}

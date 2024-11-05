import 'package:dartz/dartz.dart';
import 'package:tractian_assets/core/failure/failure.dart';
import 'package:tractian_assets/src/home/data/data_sources/home_data_source.dart';
import 'package:tractian_assets/src/home/data/errors/exeptions.dart';
import 'package:tractian_assets/src/home/domain/entities/company_entity.dart';
import 'package:tractian_assets/src/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource remoteDatasource;

  HomeRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, List<CompanyEntity>>> getCompanies() async {
    try {
      final companies = await remoteDatasource.getCompanies();
      return Right(companies);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(GetCompanyException(e.toString()));
    }
  }
}

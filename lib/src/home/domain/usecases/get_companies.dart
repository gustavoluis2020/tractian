import 'package:dartz/dartz.dart';
import 'package:tractian_assets/core/failure/failure.dart';
import 'package:tractian_assets/core/helpers/use_case.dart';
import 'package:tractian_assets/src/home/domain/entities/company_entity.dart';
import 'package:tractian_assets/src/home/domain/repositories/home_repository.dart';

class GetCompanies extends UseCase<List<CompanyEntity>, NoParams> {
  final HomeRepository repository;

  GetCompanies(this.repository);

  @override
  Future<Either<Failure, List<CompanyEntity>>> call(NoParams params) async {
    return await repository.getCompanies();
  }
}

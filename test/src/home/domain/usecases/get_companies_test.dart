import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_assets/core/helpers/use_case.dart';
import 'package:tractian_assets/src/home/data/errors/exeptions.dart';
import 'package:tractian_assets/src/home/domain/entities/company_entity.dart';
import 'package:tractian_assets/src/home/domain/repositories/home_repository.dart';
import 'package:tractian_assets/src/home/domain/usecases/get_companies.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late GetCompanies useCase;
  late MockHomeRepository mockRepository;

  setUp(() {
    mockRepository = MockHomeRepository();
    useCase = GetCompanies(mockRepository);
  });

  test('should return Right with a list of CompanyEntity when the call is successful', () async {
    // Arrange
    final companies = [CompanyEntity(id: "1", name: "Company A")];
    when(() => mockRepository.getCompanies()).thenAnswer((_) async => Right(companies));

    // Act
    final result = await useCase(NoParams());

    // Assert
    expect(result.isRight(), true);
    result.fold(
      (failure) => fail('Expected Right, got Left'),
      (data) => expect(data, isA<List<CompanyEntity>>()),
    );
  });

  test('should return Left with GetCompanyException when the call fails', () async {
    // Arrange
    when(() => mockRepository.getCompanies()).thenAnswer((_) async => Left(GetCompanyException('Error')));

    // Act
    final result = await useCase(NoParams());

    // Assert
    expect(result.isLeft(), true);
    result.fold(
      (failure) => expect(failure, isA<GetCompanyException>()),
      (_) => fail('Expected Left, got Right'),
    );
  });
}

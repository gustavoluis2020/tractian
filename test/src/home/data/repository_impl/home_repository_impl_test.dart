import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_assets/src/home/data/data_sources/home_data_source.dart';
import 'package:tractian_assets/src/home/data/errors/exeptions.dart';
import 'package:tractian_assets/src/home/data/models/company_model.dart';
import 'package:tractian_assets/src/home/data/repository_impl/home_repository_impl.dart';
import 'package:tractian_assets/src/home/domain/entities/company_entity.dart';

class MockHomeDataSource extends Mock implements HomeDataSource {}

void main() {
  late HomeRepositoryImpl repository;
  late MockHomeDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockHomeDataSource();
    repository = HomeRepositoryImpl(remoteDatasource: mockDataSource);
  });

  test('should return Right with a list of CompanyEntity when the call is successful', () async {
    // Arrange
    final companies = [CompanyModel(id: "1", name: "Company A")];
    when(() => mockDataSource.getCompanies()).thenAnswer((_) async => companies);

    // Act
    final result = await repository.getCompanies();

    // Assert
    expect(result.isRight(), true);
    result.fold(
      (failure) => fail('Expected Right, got Left'),
      (data) => expect(data, isA<List<CompanyEntity>>()),
    );
  });

  test('should return Left with GetCompanyException when the call fails', () async {
    // Arrange
    when(() => mockDataSource.getCompanies()).thenThrow(GetCompanyException('Error'));

    // Act
    final result = await repository.getCompanies();

    // Assert
    expect(result.isLeft(), true);
    result.fold(
      (failure) => expect(failure, isA<GetCompanyException>()),
      (_) => fail('Expected Left, got Right'),
    );
  });
}

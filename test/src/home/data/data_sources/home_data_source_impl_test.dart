import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:tractian_assets/src/home/data/data_sources/home_data_source_impl.dart';
import 'package:tractian_assets/src/home/data/errors/exeptions.dart';
import 'package:tractian_assets/src/home/data/models/company_model.dart';
import 'dart:convert';

class MockHttpClient extends Mock implements http.Client {}

class UriFake extends Fake implements Uri {}

void main() {
  late HomeDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(UriFake());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = HomeDataSourceImpl(client: mockHttpClient);
  });

  test('should return a list of CompanyModel when the call to API is successful', () async {
    // Arrange
    final companyJson = [
      {"id": "1", "name": "Company A"},
      {"id": "2", "name": "Company B"}
    ];
    when(() => mockHttpClient.get(any())).thenAnswer(
      (_) async => http.Response(jsonEncode(companyJson), 200),
    );

    // Act
    final result = await dataSource.getCompanies();

    // Assert
    expect(result, isA<List<CompanyModel>>());
    expect(result.length, 2);
  });

  test('should throw GetCompanyException when the call to API fails', () async {
    // Arrange
    when(() => mockHttpClient.get(any())).thenAnswer(
      (_) async => http.Response('Error', 404),
    );

    // Act
    final call = dataSource.getCompanies;

    // Assert
    expect(() => call(), throwsA(isA<GetCompanyException>()));
  });
}

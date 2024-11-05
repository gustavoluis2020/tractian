import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tractian_assets/src/assets/data/data_sources/assets_data_source_impl.dart';
import 'package:tractian_assets/src/assets/data/errors/exeptions.dart';
import 'package:tractian_assets/src/assets/data/models/asset_model.dart';
import 'package:tractian_assets/src/assets/data/models/location_model.dart';

class MockHttpClient extends Mock implements http.Client {}

class UriFake extends Fake implements Uri {}

void main() {
  late AssetsDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(UriFake());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = AssetsDataSourceImpl(client: mockHttpClient);
  });

  group('AssetsDataSourceImpl', () {
    const companyId = '123';

    test('should return a list of LocationModel when getLocationsByCompany is successful', () async {
      final locationJson = [
        {"id": "1", "name": "Location A"},
        {"id": "2", "name": "Location B"}
      ];

      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response(jsonEncode(locationJson), 200),
      );

      final result = await dataSource.getLocationsByCompany(companyId);

      expect(result, isA<List<LocationModel>>());
      expect(result.length, 2);
    });

    test('should throw GetLocationException when the call to API fails', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response('Error', 404),
      );

      // Act
      final call = dataSource.getLocationsByCompany(companyId);

      // Assert
      expect(call, throwsA(isA<GetLocationException>()));
    });

    test('should return a list of AssetModel when getAssetsByCompany is successful', () async {
      final assetJson = [
        {
          "id": "1",
          "name": "Asset A",
          "sensorType": "Temp",
          "status": "Active",
          "gatewayId": "G1",
          "sensorId": "S1",
        },
        {
          "id": "2",
          "name": "Asset B",
          "sensorType": "Humidity",
          "status": "Inactive",
          "gatewayId": "G2",
          "sensorId": "S2"
        }
      ];

      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response(jsonEncode(assetJson), 200),
      );

      final result = await dataSource.getAssetsByCompany(companyId);

      expect(result, isA<List<AssetModel>>());
      expect(result.length, 2);
    });

    test('should throw GetLocationException when the call to API fails', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response('Error', 404),
      );

      // Act
      final call = dataSource.getAssetsByCompany(companyId);

      // Assert
      expect(call, throwsA(isA<GetAssetException>()));
    });
  });
}

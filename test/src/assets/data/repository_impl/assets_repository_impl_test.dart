import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:tractian_assets/core/failure/failure.dart';
import 'package:tractian_assets/src/assets/data/data_sources/assets_data_source.dart';
import 'package:tractian_assets/src/assets/data/errors/exeptions.dart';
import 'package:tractian_assets/src/assets/data/models/asset_model.dart';
import 'package:tractian_assets/src/assets/data/models/location_model.dart';
import 'package:tractian_assets/src/assets/data/repository_impl/assets_repository_impl.dart';
import 'package:tractian_assets/src/assets/domain/entities/asset_entity.dart';
import 'package:tractian_assets/src/assets/domain/entities/location_entity.dart';

class MockAssetsDataSource extends Mock implements AssetsDataSource {}

void main() {
  late AssetsRepositoryImpl repository;
  late MockAssetsDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockAssetsDataSource();
    repository = AssetsRepositoryImpl(remoteDatasource: mockDataSource);
  });

  group('AssetsRepositoryImpl', () {
    const companyId = '123';

    test('should return Right(List<LocationEntity>) when getLocationsByCompany is successful', () async {
      final locations = [LocationModel(id: '1', name: 'Location A'), LocationModel(id: '2', name: 'Location B')];

      when(() => mockDataSource.getLocationsByCompany(companyId)).thenAnswer((_) async => locations);

      final result = await repository.getLocationsByCompany(companyId);

      expect(result, Right(locations));
    });

    test('should return Right(List<AssetEntity>) when getAssetsByCompany is successful', () async {
      final assets = [
        AssetModel(id: '1', name: 'Asset A', sensorType: 'Temp', status: 'Active', gatewayId: 'G1', sensorId: 'S1'),
        AssetModel(
            id: '2', name: 'Asset B', sensorType: 'Humidity', status: 'Inactive', gatewayId: 'G2', sensorId: 'S2')
      ];

      when(() => mockDataSource.getAssetsByCompany(companyId)).thenAnswer((_) async => assets);

      final result = await repository.getAssetsByCompany(companyId);

      expect(result, Right(assets));
    });

    test('should return Left(GetLocationException) when getLocationsByCompany fails', () async {
      when(() => mockDataSource.getLocationsByCompany(companyId)).thenThrow(GetLocationException('Error'));

      final result = await repository.getLocationsByCompany(companyId);

      expect(result, isA<Left<Failure, List<LocationEntity>>>());
    });

    test('should return Left(GetAssetException) when getAssetsByCompany fails', () async {
      when(() => mockDataSource.getAssetsByCompany(companyId)).thenThrow(GetAssetException('Error'));

      final result = await repository.getAssetsByCompany(companyId);

      expect(result, isA<Left<Failure, List<AssetEntity>>>());
    });
  });
}

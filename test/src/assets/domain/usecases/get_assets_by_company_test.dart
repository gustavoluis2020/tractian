import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:tractian_assets/core/failure/failure.dart';
import 'package:tractian_assets/src/assets/data/errors/exeptions.dart';
import 'package:tractian_assets/src/assets/domain/entities/asset_entity.dart';
import 'package:tractian_assets/src/assets/domain/repositories/assets_repository.dart';
import 'package:tractian_assets/src/assets/domain/usecases/get_assets_by_company.dart';

class MockAssetsRepository extends Mock implements AssetsRepository {}

void main() {
  late GetAssetsByCompany getAssetsByCompany;

  late MockAssetsRepository mockRepository;

  setUp(() {
    mockRepository = MockAssetsRepository();
    getAssetsByCompany = GetAssetsByCompany(mockRepository);
  });

  const companyId = '123';

  group('GetAssetsByCompany Use Case', () {
    test('should return Right(List<AssetEntity>) when repository call is successful', () async {
      final assets = [
        AssetEntity(id: '1', name: 'Asset A', sensorType: 'Temp', status: 'Active', gatewayId: 'G1', sensorId: 'S1'),
        AssetEntity(
            id: '2', name: 'Asset B', sensorType: 'Humidity', status: 'Inactive', gatewayId: 'G2', sensorId: 'S2')
      ];

      when(() => mockRepository.getAssetsByCompany(companyId)).thenAnswer((_) async => Right(assets));

      final result = await getAssetsByCompany(companyId);

      expect(result, Right(assets));
    });

    test('should return Left(GetAssetException) when repository call fails', () async {
      when(() => mockRepository.getAssetsByCompany(companyId))
          .thenAnswer((_) async => Left(GetAssetException('Error')));

      final result = await getAssetsByCompany(companyId);

      expect(result, isA<Left<Failure, List<AssetEntity>>>());
    });
  });
}

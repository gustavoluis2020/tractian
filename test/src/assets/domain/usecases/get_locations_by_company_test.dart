import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:tractian_assets/core/failure/failure.dart';
import 'package:tractian_assets/src/assets/data/errors/exeptions.dart';
import 'package:tractian_assets/src/assets/domain/entities/location_entity.dart';
import 'package:tractian_assets/src/assets/domain/repositories/assets_repository.dart';
import 'package:tractian_assets/src/assets/domain/usecases/get_locations_by_company.dart';

class MockAssetsRepository extends Mock implements AssetsRepository {}

void main() {
  late GetLocationsByCompany getLocationsByCompany;
  late MockAssetsRepository mockRepository;

  setUp(() {
    mockRepository = MockAssetsRepository();

    getLocationsByCompany = GetLocationsByCompany(mockRepository);
  });

  const companyId = '123';

  group('GetLocationsByCompany Use Case', () {
    test('should return Right(List<LocationEntity>) when repository call is successful', () async {
      final locations = [
        LocationEntity(id: '1', name: 'Location A'),
        LocationEntity(id: '2', name: 'Location B'),
      ];

      when(() => mockRepository.getLocationsByCompany(companyId)).thenAnswer(
        (_) async => Right(locations),
      );

      final result = await getLocationsByCompany(companyId);

      expect(result, Right(locations));
    });

    test('should return Left(GetLocationException) when repository call fails', () async {
      when(() => mockRepository.getLocationsByCompany(companyId)).thenAnswer(
        (_) async => Left(
          GetLocationException('Error'),
        ),
      );

      final result = await getLocationsByCompany(companyId);

      expect(result, isA<Left<Failure, List<LocationEntity>>>());
    });
  });
}

import 'package:tractian_assets/src/assets/domain/entities/node_entity.dart';

class LocationEntity extends NodeEntity {
  LocationEntity({
    required super.id,
    required super.name,
    super.parentId,
  });
}

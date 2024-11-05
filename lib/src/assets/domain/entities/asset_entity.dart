import 'package:tractian_assets/src/assets/domain/entities/node_entity.dart';

class AssetEntity extends NodeEntity {
  final String sensorType;
  final String status;
  final String gatewayId;
  final String sensorId;

  AssetEntity({
    required super.id,
    required super.name,
    super.parentId,
    super.locationId,
    required this.sensorType,
    required this.status,
    required this.gatewayId,
    required this.sensorId,
  });
}

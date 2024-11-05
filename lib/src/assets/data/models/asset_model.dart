import 'package:tractian_assets/src/assets/domain/entities/asset_entity.dart';

class AssetModel extends AssetEntity {
  AssetModel({
    required super.id,
    super.locationId,
    required super.name,
    super.parentId,
    required super.sensorType,
    required super.status,
    required super.gatewayId,
    required super.sensorId,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    return AssetModel(
      id: json['id'] ?? '',
      locationId: json['locationId'] ?? '',
      name: json['name'] ?? '',
      parentId: json['parentId'] ?? '',
      sensorType: json['sensorType'] ?? '',
      status: json['status'] ?? '',
      gatewayId: json['gatewayId'] ?? '',
      sensorId: json['sensorId'] ?? '',
    );
  }
}

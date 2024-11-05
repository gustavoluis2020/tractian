import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_assets/src/assets/domain/entities/node_entity.dart';
import 'package:tractian_assets/src/assets/domain/entities/asset_entity.dart';
import 'package:tractian_assets/src/assets/domain/entities/location_entity.dart';
import 'package:tractian_assets/src/assets/domain/usecases/get_assets_by_company.dart';
import 'package:tractian_assets/src/assets/domain/usecases/get_locations_by_company.dart';

class AssetsController extends GetxController {
  @override
  void onInit() async {
    super.onInit();

    getArgs();

    await getAssets();
    await getLocations();
    nodeList();
  }

  getArgs() {
    Map<String, dynamic>? args = Get.arguments;
    if (args != null) {
      if (args['companyId'] != null) {
        companyId = args['companyId'];
      }
    }
  }

  String companyId = '';

  RxBool isLoading = false.obs;
  RxBool isButtonActiveEnergy = false.obs;
  RxBool isButtonActiveCritical = false.obs;
  RxBool isLoadingListAction = false.obs;

  RxMap<NodeEntity, bool> expandedNodes = <NodeEntity, bool>{}.obs;

  RxList<AssetEntity> assetsList = <AssetEntity>[].obs;
  RxList<LocationEntity> locationsList = <LocationEntity>[].obs;
  RxList<NodeEntity> nodesList = <NodeEntity>[].obs;
  RxList<NodeEntity> nodesListFiltered = <NodeEntity>[].obs;

  Future<void> getLocations() async {
    isLoading.value = true;
    GetLocationsByCompany getLocationsByCompany = Get.find();
    final result = await getLocationsByCompany(companyId);
    result.fold((l) {
      debugPrint(l.toString());
      isLoading.value = false;
    }, (r) {
      locationsList.value = r;
      isLoading.value = false;
    });
  }

  Future<void> getAssets() async {
    isLoading.value = true;
    GetAssetsByCompany getAssetsByCompany = Get.find();
    final result = await getAssetsByCompany(companyId);
    result.fold((l) {
      debugPrint(l.toString());
      isLoading.value = false;
    }, (r) {
      assetsList.value = r;
      isLoading.value = false;
    });
  }

  void toggleButtonEnergy() {
    isButtonActiveEnergy.value = !isButtonActiveEnergy.value;
    filterListFromEnergySensors();
  }

  void toggleExpansion(NodeEntity node) {
    expandedNodes[node] = !(expandedNodes[node] ?? false);
    update();
  }

  void nodeList() {
    isLoadingListAction.value = true;
    final Map<String, List<NodeEntity>> childrenMap = {};
    final Set<String> assignedChildIds = {};

    final Map<String, NodeEntity> nodeById = {};

    final List<NodeEntity> nodes = [
      ...locationsList,
      ...assetsList,
    ];

    for (var node in nodes) {
      nodeById[node.id] = node;
      childrenMap[node.id] = [];
    }

    for (var node in nodes) {
      if (node.parentId != null && nodeById.containsKey(node.parentId)) {
        childrenMap[node.parentId]!.add(node);
        assignedChildIds.add(node.id);
      } else if (node.locationId != null && nodeById.containsKey(node.locationId)) {
        childrenMap[node.locationId]!.add(node);
        assignedChildIds.add(node.id);
      }
    }

    for (var node in nodes) {
      node.children = childrenMap[node.id] ?? [];
    }

    nodesList.value = nodes
        .where((node) => (node.parentId == null && node.locationId == null) || !assignedChildIds.contains(node.id))
        .toList();

    sortByChildren();

    nodesListFiltered.value = nodesList;

    isLoadingListAction.value = false;
  }

  void sortByChildren() {
    nodesList.sort((a, b) {
      bool aHasChildren = a.children.isNotEmpty;
      bool bHasChildren = b.children.isNotEmpty;

      if (aHasChildren && !bHasChildren) {
        return -1;
      } else if (!aHasChildren && bHasChildren) {
        return 1;
      } else {
        return 0;
      }
    });
  }

  void filterListFromText(String filter) {
    nodesList.value = [
      ...locationsList.cast<NodeEntity>(),
      ...assetsList.cast<NodeEntity>(),
    ];
    if (filter.isEmpty) {
      nodesListFiltered.value = nodesList;
      return;
    }
    final list = nodesList.where((e) => e.name.toLowerCase().trim().contains(filter.toLowerCase().trim()));
    nodesListFiltered.value = list.toList();
  }

  void filterListFromEnergySensors() {
    if (isButtonActiveEnergy.value) {
      final list = assetsList.where((e) => e.sensorType.toLowerCase().contains("energy")).toList();
      nodesListFiltered.value = list;
    } else {
      nodesListFiltered.value = nodesList;
    }
  }

  void toggleButtonCritical() {
    isButtonActiveCritical.value = !isButtonActiveCritical.value;

    if (isButtonActiveCritical.value) {
      filterListFromCriticalAlert();
    } else {
      expandedNodes.clear();
      nodesListFiltered.value = nodesList;
    }
  }

  void filterListFromCriticalAlert() {
    final criticalAssets = assetsList
        .where(
          (e) => e.status.toLowerCase().contains("alert"),
        )
        .toList();

    final allRelevantAssets = <NodeEntity>{};
    for (final asset in criticalAssets) {
      NodeEntity? current = asset;
      while (current != null) {
        allRelevantAssets.add(current);
        current = findParent(current);
      }
    }

    for (final node in allRelevantAssets) {
      expandedNodes[node] = true;
    }

    nodesListFiltered.value = allRelevantAssets.toList();
  }

  NodeEntity? findParent(NodeEntity node) {
    final allNodes = [...locationsList, ...assetsList];
    return allNodes.firstWhereOrNull((e) => e.id == node.parentId || e.id == node.locationId);
  }
}

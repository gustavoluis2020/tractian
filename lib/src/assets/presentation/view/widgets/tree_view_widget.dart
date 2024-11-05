import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_assets/src/assets/domain/entities/node_entity.dart';
import 'package:tractian_assets/src/assets/domain/entities/asset_entity.dart';
import 'package:tractian_assets/src/assets/domain/entities/location_entity.dart';
import 'package:tractian_assets/src/assets/presentation/view/widgets/asset_widget.dart';
import 'package:tractian_assets/src/assets/presentation/view/widgets/location_widget.dart';

class TreeViewWidget extends StatelessWidget {
  final List<NodeEntity> nodes;
  final void Function(NodeEntity) onNodeTapped;
  final RxMap<NodeEntity, bool> expandedNodes;

  const TreeViewWidget({
    super.key,
    required this.nodes,
    required this.onNodeTapped,
    required this.expandedNodes,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Expanded(
        child: ListView.builder(
          itemCount: nodes.length,
          itemBuilder: (context, index) {
            return _buildNode(nodes[index], 0);
          },
        ),
      );
    });
  }

  Widget _buildNode(NodeEntity node, int level) {
    final bool isExpanded = expandedNodes[node] ?? false;
    final bool hasChildren = node.children.isNotEmpty;
    final Widget nodeWidget = node is LocationEntity
        ? LocationWidget(
            item: node,
            isExpanded: isExpanded,
            showChevron: hasChildren,
            onTap: () => onNodeTapped(node),
          )
        : AssetsWidget(
            item: node as AssetEntity,
            isExpanded: isExpanded,
            isComponent: node.children.isEmpty || (node).sensorType == 'component',
            onTap: () => onNodeTapped(node),
          );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 2),
          child: nodeWidget,
        ),
        if (isExpanded && hasChildren)
          Padding(
            padding: EdgeInsets.only(left: (level + 1) * 16.0, top: 5),
            child: Column(
              children: node.children.map((child) => _buildNode(child, level + 1)).toList(),
            ),
          ),
      ],
    );
  }
}

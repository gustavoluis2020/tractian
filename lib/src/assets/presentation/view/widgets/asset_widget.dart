import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tractian_assets/core/constants/app_assets.dart';
import 'package:tractian_assets/core/constants/app_colors.dart';
import 'package:tractian_assets/src/assets/domain/entities/asset_entity.dart';

class AssetsWidget extends StatelessWidget {
  final AssetEntity item;
  final bool isExpanded;
  final bool isComponent;
  final void Function()? onTap;

  const AssetsWidget({
    super.key,
    required this.item,
    required this.isExpanded,
    required this.isComponent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          if (!isComponent)
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Icon(
                isExpanded ? CupertinoIcons.chevron_down : CupertinoIcons.chevron_right,
                size: 15,
              ),
            ),
          item.sensorType.contains('vibration') || item.sensorType.contains('energy')
              ? Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  child: Image.asset(
                    AppAssets.component,
                    width: 22,
                    height: 22,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  child: Image.asset(
                    AppAssets.asset,
                    width: 22,
                    height: 22,
                  ),
                ),
          Flexible(
            child: Text(
              item.name,
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          item.sensorType.contains('energy') && item.gatewayId.isNotEmpty && item.status.contains('alert')
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.bolt_fill,
                        color: Colors.green,
                        size: 12,
                      ),
                      Icon(
                        CupertinoIcons.circle_fill,
                        color: AppColors.redError,
                        size: 12,
                      ),
                    ],
                  ),
                )
              : item.sensorType.contains('energy') && item.gatewayId.isNotEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        CupertinoIcons.bolt_fill,
                        color: Colors.green,
                        size: 12,
                      ),
                    )
                  : const SizedBox.shrink(),

          //const SizedBox.shrink(),
          item.status.contains('operating') && !item.sensorType.contains('energy')
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    CupertinoIcons.circle_fill,
                    color: Colors.green,
                    size: 12,
                  ),
                )
              : const SizedBox.shrink(),
          if (item.status.contains('alert') && !item.sensorType.contains('energy'))
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                CupertinoIcons.circle_fill,
                size: 12,
                color: AppColors.redError,
              ),
            ),
        ],
      ),
    );
  }
}

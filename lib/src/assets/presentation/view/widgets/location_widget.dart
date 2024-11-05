import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tractian_assets/core/constants/app_assets.dart';
import 'package:tractian_assets/core/constants/app_colors.dart';
import 'package:tractian_assets/src/assets/domain/entities/location_entity.dart';

class LocationWidget extends StatelessWidget {
  final LocationEntity item;
  final bool isExpanded;
  final bool showChevron;
  final void Function()? onTap;

  const LocationWidget({
    super.key,
    required this.item,
    required this.isExpanded,
    required this.showChevron,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          if (showChevron)
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: Icon(
                isExpanded ? CupertinoIcons.chevron_down : CupertinoIcons.chevron_right,
                size: 15,
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(left: 2.0, right: 4.0, top: 9.0),
            child: Image.asset(
              AppAssets.location,
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
        ],
      ),
    );
  }
}

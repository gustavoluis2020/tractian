import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AssetShimmerWidget extends StatelessWidget {
  const AssetShimmerWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        index,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 28,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

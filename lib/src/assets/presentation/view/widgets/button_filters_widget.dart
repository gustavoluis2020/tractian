import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_assets/core/constants/app_colors.dart';

class ButtonFiltersWidget extends StatelessWidget {
  final String svgPath;
  final String text;
  final bool isActive;
  final VoidCallback onPressed;

  const ButtonFiltersWidget({
    super.key,
    required this.svgPath,
    required this.text,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.only(left: 14, right: 16),
        height: 32,
        decoration: BoxDecoration(
          color: isActive ? AppColors.blue : AppColors.white,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            color: isActive ? AppColors.blue : AppColors.greyBorder,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              colorFilter: ColorFilter.mode(
                isActive ? AppColors.white : AppColors.grey,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isActive ? AppColors.white : AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

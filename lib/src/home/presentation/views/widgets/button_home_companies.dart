import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_assets/core/constants/app_assets.dart';
import 'package:tractian_assets/core/constants/app_colors.dart';

class ButtonHomeCompanies extends StatelessWidget {
  const ButtonHomeCompanies({super.key, required this.nameCompany, required this.onTap});

  final String nameCompany;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 76,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.blue,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.asset(
                    AppAssets.logoCompanies,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  nameCompany,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  'Unit',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

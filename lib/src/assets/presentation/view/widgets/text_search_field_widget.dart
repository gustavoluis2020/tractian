import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tractian_assets/core/constants/app_colors.dart';

class TextSearchFieldWidget extends StatelessWidget {
  final String? hintText;
  final void Function(String)? onChanged;

  const TextSearchFieldWidget({
    super.key,
    this.hintText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: AppColors.greySearchField,
        prefixIcon: const Icon(CupertinoIcons.search, color: AppColors.greyText),
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.greyText, fontSize: 14, fontWeight: FontWeight.w400),
        contentPadding: EdgeInsets.zero,
        constraints: const BoxConstraints(
          minHeight: 32.0,
          maxHeight: 32.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

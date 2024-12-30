import 'package:filter_app/core/color.dart';
import 'package:filter_app/core/constants.dart';
import 'package:flutter/material.dart';

class DetailsTitleWidget extends StatelessWidget {
  final String label;
  final String value;
  const DetailsTitleWidget({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: ColorsManager.blackColor.withOpacity(0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
        kSizedBox4,
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: ColorsManager.blackColor,
          ),
        ),
      ],
    );
  }
}

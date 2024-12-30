import 'package:filter_app/core/color.dart';
import 'package:flutter/material.dart';

class SearchTextFieldWidget extends StatelessWidget {
  final String searchQuery;
  final Function(String) onSearchQueryChanged;

  const SearchTextFieldWidget({super.key,
    required this.searchQuery,
    required this.onSearchQueryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: ColorsManager.oliveGreenColor,
      style: TextStyle(
          color: ColorsManager.blackColor, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: "Search for $searchQuery",
        hintStyle: TextStyle(color: ColorsManager.blackColor.withOpacity(0.3)),
        prefixIcon: Icon(Icons.search,color: ColorsManager.oliveGreenColor,),
        filled: true,
        fillColor: ColorsManager.whiteColor,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorsManager.oliveGreenColor),
            borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorsManager.oliveGreenColor),
            borderRadius: BorderRadius.circular(12)),
      ),
      onChanged: onSearchQueryChanged,
    );
  }
}

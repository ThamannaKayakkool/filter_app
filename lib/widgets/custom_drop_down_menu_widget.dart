import 'package:filter_app/core/color.dart';
import 'package:flutter/material.dart';

class CustomDropDownWidget extends StatelessWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  const CustomDropDownWidget({super.key, this.value, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
        value: value,
        hint: const Text('Select'),
        dropdownColor: ColorsManager.whiteColor,

        items: items.map(
              (item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          },
        ).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorsManager.whiteColor,
          hintStyle: const TextStyle(color: Colors.black26, fontSize: 16),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorsManager.burgundyColor,
              ),
              borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
              borderSide:  BorderSide(
                color: ColorsManager.burgundyColor,
              ),
              borderRadius: BorderRadius.circular(12)),
        ));
  }
}

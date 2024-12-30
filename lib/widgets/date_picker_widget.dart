import 'package:filter_app/core/color.dart';
import 'package:flutter/material.dart';

class DatePickerWidget extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  DatePickerWidget({super.key,
    required this.label,
    DateTime? selectedDate,
    required this.onDateSelected,
  }) : selectedDate = selectedDate ?? DateTime.now();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: ColorsManager.oliveGreenColor,
                  onPrimary: ColorsManager.whiteColor,
                  onSurface: ColorsManager.blackColor,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: ColorsManager.oliveGreenColor,
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
        if (pickedDate != null) {
          onDateSelected(pickedDate);
        }
      },
      child: _buildDateBox(),
    );
  }

  Widget _buildDateBox() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: selectedDate == null
            ? ColorsManager.oliveGreenColor.withOpacity(0.2)
            : ColorsManager.oliveGreenColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Row(
          children: [
            Text(
              selectedDate != null
                  ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                  : label,
              style: TextStyle(
                color: selectedDate == null
                    ? ColorsManager.blackColor.withOpacity(0.2)
                    : ColorsManager.whiteColor,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.calendar_today,
              color: selectedDate == null
                  ? ColorsManager.blackColor.withOpacity(0.2)
                  : ColorsManager.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}

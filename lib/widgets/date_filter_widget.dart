import 'package:filter_app/bloc/filter_bloc.dart';
import 'package:filter_app/core/color.dart';
import 'package:filter_app/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateFilterWidget extends StatelessWidget {
  const DateFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TextButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: ColorsManager.whiteColor,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Date Range',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    kSizedBox16,
                    BlocBuilder<FilterBloc, FilterState>(
                      builder: (context, state) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.timePeriods.keys.length,
                          itemBuilder: (context, index) {
                            final key = state.timePeriods.keys.elementAt(index);
                            return CheckboxListTile(
                              checkColor: ColorsManager.whiteColor,
                              activeColor: ColorsManager.oliveGreenColor,
                              title: Text(
                                key,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: ColorsManager.blackColor),
                              ),
                              subtitle: Text(
                                _getDateRangeForKey(key),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 12),
                              ),
                              value: state.timePeriods[key],
                              onChanged: (bool? value) {
                                if (value != null) {
                                  context
                                      .read<FilterBloc>()
                                      .add(ToggleTimePeriod(key));
                                }
                              },
                            );
                          },
                        );
                      },
                    ),
                    kSizedBox16,
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: ColorsManager.whiteColor,
                          backgroundColor: ColorsManager.oliveGreenColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          context.read<FilterBloc>().add(ApplyDateRange());
                          Navigator.pop(context);
                        },
                        child: Text('Apply',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: ColorsManager.whiteColor)),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Text(
          'Change',
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 13,
              color: ColorsManager.oliveGreenColor),
        ),
      ),
    );
  }

  String _getDateRangeForKey(String key) {
    final now = DateTime.now();
    DateTime fromDate, toDate;

    if (key == 'Today') {
      fromDate = now;
      toDate = now;
    } else if (key == 'This Week') {
      fromDate = now.subtract(Duration(days: now.weekday - 1));
      toDate = now.add(Duration(days: 7 - now.weekday));
    } else if (key == 'Last Week') {
      final startOfThisWeek = now.subtract(Duration(days: now.weekday - 1));
      fromDate = startOfThisWeek.subtract(const Duration(days: 7));
      toDate = startOfThisWeek.subtract(const Duration(days: 1));
    } else if (key == 'This Month') {
      fromDate = DateTime(now.year, now.month, 1);
      toDate = DateTime(now.year, now.month + 1, 0);
    } else if (key == 'Last Month') {
      final lastMonth = DateTime(now.year, now.month - 1, 1);
      fromDate = lastMonth;
      toDate = DateTime(lastMonth.year, lastMonth.month + 1, 0);
    } else if (key == 'This Quarter') {
      final quarterStartMonth = ((now.month - 1) ~/ 3) * 3 + 1;
      fromDate = DateTime(now.year, quarterStartMonth, 1);
      toDate = DateTime(now.year, quarterStartMonth + 3, 0);
    } else if (key == 'Last Quarter') {
      final currentQuarter = ((now.month - 1) ~/ 3) * 3 + 1;
      final lastQuarterStartMonth = currentQuarter - 3;
      fromDate = DateTime(now.year, lastQuarterStartMonth, 1);
      toDate = DateTime(now.year, lastQuarterStartMonth + 3, 0);
    } else if (key == 'Current Fiscal Year') {
      fromDate = DateTime(now.year, 4, 1);
      toDate = DateTime(now.year + 1, 3, 31);
    } else if (key == 'Previous Fiscal Year') {
      fromDate = DateTime(now.year - 1, 4, 1);
      toDate = DateTime(now.year, 3, 31);
    } else {
      return '';
    }

    return '${_formatDate(fromDate)} - ${_formatDate(toDate)}';
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}

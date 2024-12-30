import 'package:filter_app/core/color.dart';
import 'package:filter_app/core/constants.dart';
import 'package:filter_app/widgets/details_title_widget.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> filteredData;
  const DetailsScreen({super.key, required this.filteredData});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemBuilder: (context, index) {
          final item = filteredData[index];
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: ColorsManager.oliveGreenColor),
              color: ColorsManager.whiteColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: ColorsManager.blackColor.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: ColorsManager.oliveGreenColor,
                        child: Text(
                          item['name']?.substring(0, 1)?.toUpperCase() ?? '',
                          style: TextStyle(
                            color: ColorsManager.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      kSizedBoxW16,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'] ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ColorsManager.blackColor,
                              ),
                            ),
                            kSizedBox4,
                            Text(
                              'Mobile: ${item['mobile']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: ColorsManager.blackColor.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  kSizedBox16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DetailsTitleWidget(
                        label: 'Purchase Code',
                        value: item['purchaseCode'],
                      ),
                      DetailsTitleWidget(
                        label: 'Payment Type',
                        value: item['paymentType'],
                      ),
                      DetailsTitleWidget(
                        label: 'Date',
                        value: item['date'].toString().substring(0, 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => kSizedBox20,
        itemCount: filteredData.length,
      ),
    );
  }
}

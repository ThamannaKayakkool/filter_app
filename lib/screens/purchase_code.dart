import 'package:filter_app/core/color.dart';
import 'package:filter_app/core/constants.dart';
import 'package:filter_app/screens/name.dart';
import 'package:filter_app/widgets/custom_button_widget.dart';
import 'package:filter_app/widgets/details_title_widget.dart';
import 'package:flutter/material.dart';

class PurchaseCode extends StatefulWidget {
  const PurchaseCode({super.key});

  @override
  State<PurchaseCode> createState() => _PurchaseCodeState();
}

class _PurchaseCodeState extends State<PurchaseCode> {
  final Set<String> selectedPurchaseCode = {};

  List<MapEntry<String, dynamic>> get filteredCustomerData {
    return customerData.entries
        .where((entry) => selectedPurchaseCode.contains(entry.value['purchaseCode']))
        .toList();
  }

  void showPaymentTypeSelector(BuildContext context) {
    final paymentTypes = customerData.values
        .map((e) => e['purchaseCode'])
        .toSet()
        .toList();

    showModalBottomSheet(
      backgroundColor: ColorsManager.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              width: double.infinity,
              height: 400,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Select Purchase Code',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.blackColor,
                      ),
                    ),
                  ),
                  kSizedBox10,
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 8.0,
                        children: paymentTypes
                            .map((paymentType) => FilterChip(
                          checkmarkColor: ColorsManager.whiteColor,
                          label: Text(
                            paymentType,
                            style: TextStyle(
                              color: selectedPurchaseCode
                                  .contains(paymentType)
                                  ? ColorsManager.whiteColor
                                  : ColorsManager.blackColor,
                            ),
                          ),
                          selected:
                          selectedPurchaseCode.contains(paymentType),
                          selectedColor: ColorsManager.burgundyColor,
                          backgroundColor: ColorsManager.whiteColor,
                          onSelected: (selected) {
                            setModalState(() {
                              if (selected) {
                                selectedPurchaseCode.add(paymentType);
                              } else {
                                selectedPurchaseCode.remove(paymentType);
                              }
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          shadowColor: Colors.black.withOpacity(0.1),
                        ))
                            .toList(),
                      ),
                    ),
                  ),
                  kSizedBox15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButtonWidget(
                        text: 'Cancel',
                        width: 180,
                        height: 40,
                        backgroundColor: ColorsManager.burgundyColor,
                        textColor: ColorsManager.whiteColor,
                        onPressed: () => Navigator.pop(context),
                      ),
                      CustomButtonWidget(
                        text: 'Apply',
                        width: 180,
                        height: 40,
                        backgroundColor: ColorsManager.burgundyColor,
                        textColor: ColorsManager.whiteColor,
                        onPressed: () {
                          setState(() {
                            customerData.entries
                                .where((entry) =>
                                selectedPurchaseCode.contains(entry.value['purchaseCode']))
                                .toList();
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        kSizedBox8,
        CustomButtonWidget(
          text: 'Select',
          width: 140,
          height: 40,
          backgroundColor: ColorsManager.burgundyColor,
          textColor: ColorsManager.whiteColor,
          onPressed: () => showPaymentTypeSelector(context),
        ),
        if (selectedPurchaseCode.isNotEmpty)
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: filteredCustomerData.length,
              itemBuilder: (context, index) {
                final entry = filteredCustomerData[index];
                final item = entry.value;
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorsManager.burgundyColor),
                    color: ColorsManager.whiteColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
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
                              backgroundColor: ColorsManager.burgundyColor,
                              child: Text(
                                entry.key.substring(0, 1).toUpperCase(),
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
                                    entry.key,
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
            ),
          ),
      ],
    );
  }
}

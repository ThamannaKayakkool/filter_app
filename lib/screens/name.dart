import 'package:filter_app/core/color.dart';
import 'package:filter_app/core/constants.dart';
import 'package:filter_app/widgets/custom_button_widget.dart';
import 'package:filter_app/widgets/details_title_widget.dart';
import 'package:flutter/material.dart';

class Name extends StatefulWidget {
  const Name({super.key});

  @override
  State<Name> createState() => _NameState();
}

class _NameState extends State<Name> {
  String? selectedName;

  void showNameSelector(BuildContext context) {
    final names = customerData.keys.toList();

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
                      'Select Name',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.blackColor,
                      ),
                    ),
                  ),
                  kSizedBox10,
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: names.length,
                      itemBuilder: (context, index) {
                        final name = names[index];
                        return ListTile(
                          title: Text(
                            name,
                            style: TextStyle(
                              color: selectedName == name
                                  ? ColorsManager.burgundyColor
                                  : ColorsManager.blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap: () {
                            setModalState(() {
                              selectedName = name;
                            });
                          },
                        );
                      },
                      separatorBuilder: (context, index) =>
                          kSizedBox8,
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
                          setState(() {});
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
          text: 'Select Name',
          width: 140,
          height: 40,
          backgroundColor: ColorsManager.burgundyColor,
          textColor: ColorsManager.whiteColor,
          onPressed: () => showNameSelector(context),
        ),
        const SizedBox(height: 20),
        if (selectedName != null)
          CustomerDetailPage(customerName: selectedName!)
        // Pass selectedName here
      ],
    );
  }
}

class CustomerDetailPage extends StatelessWidget {
  final String customerName;

  const CustomerDetailPage({super.key, required this.customerName});

  @override
  Widget build(BuildContext context) {
    final customer = customerData[customerName];

    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          Container(
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
                          customerName.substring(0, 1).toUpperCase(),
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
                              customerName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ColorsManager.blackColor,
                              ),
                            ),
                            kSizedBox4,
                            Text(
                              'Mobile: ${customer['mobile']}',
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                    ColorsManager.blackColor.withOpacity(0.7),
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
                        value: customer['purchaseCode'],
                      ),
                      DetailsTitleWidget(
                        label: 'Payment Type',
                        value: customer['paymentType'],
                      ),
                      DetailsTitleWidget(
                        label: 'Date',
                        value: customer['date'].toString().substring(0, 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:filter_app/core/color.dart';
import 'package:filter_app/core/constants.dart';
import 'package:filter_app/widgets/custom_drop_down_menu_widget.dart';
import 'package:filter_app/widgets/custom_text_field.dart';
import 'package:filter_app/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _purchaseController = TextEditingController();
  final TextEditingController _paymentTypeController = TextEditingController();

  String? _selectCustomer;
  String? _selectMobileNumber;
  DateTime? _fromDate;
  DateTime? _toDate;

  @override
  void dispose() {
    _mobileController.dispose();
    _purchaseController.dispose();
    _paymentTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Filter',
          style: TextStyle(
              color: ColorsManager.blackColor, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          left: 35,
          right: 35,
        ),
        children: [
          const CustomTextWidget(text: 'Customer Name'),
          kSizedBox8,
          CustomDropDownWidget(
              value: _selectCustomer,
              items: customerData.keys.toList(),
              onChanged: (value) {
                setState(() {
                  _selectCustomer = value;
                });
              },),
          kSizedBox15,
          const CustomTextWidget(text: 'Mobile Number'),
          CustomDropDownWidget(
            value: _selectMobileNumber,
            items: customerData.entries
                .map((entry) => entry.value['mobile'].toString())
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectMobileNumber = value;
              });
            },),
          kSizedBox15,
          CustomTextField(
            label: 'Purchase Code',
            controller: _purchaseController,
            onTap: () {
              _showPurchaseCodeSelector(context);
            },

          ),
          kSizedBox15,
          CustomTextField(
            label: 'Payment Type',
            controller: _paymentTypeController,
            onTap: () {
              _showPaymentTypeSelector(context);
            },
          ),

          kSizedBox15,
          const CustomTextWidget(text: 'Date Range'),
          kSizedBox8,
          Row(
            children: [
              Expanded(
                  child: InkWell(
                onTap: () => _pickDate(isFromDate: true),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorsManager.burgundyColor,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(_fromDate == null
                      ? 'From'
                      : '${_fromDate!.day}/${_fromDate!.month}/${_fromDate!.year}'),
                ),
              )),
              kSizedBoxW14,
              Expanded(
                  child: InkWell(
                onTap: () => _pickDate(isFromDate: false),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorsManager.burgundyColor,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(_toDate == null
                      ? 'To'
                      : '${_toDate!.day}/${_toDate!.month}/${_toDate!.year}'),
                ),
              )),
            ],
          ),
          kSizedBox25,
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: ColorsManager.whiteColor,
                backgroundColor: ColorsManager.burgundyColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _applyFilter,
              child: const CustomTextWidget(text: 'Apply'))
        ],
      ),
    );
  }

  void updateCustomerDetails(String? selectCustomer) {
    if (selectCustomer != null && customerData.containsKey(selectCustomer)) {
      setState(() {
        _selectCustomer = selectCustomer;
        // Update the related fields based on the selected customer
        _mobileController.text = customerData[selectCustomer]!['mobile'] ?? '';
        _purchaseController.text = customerData[selectCustomer]!['purchaseCode'] ?? '';
        _paymentTypeController.text = customerData[selectCustomer]!['paymentType'] ?? '';
      });
    } else {
      // Clear the fields if no customer is selected
      setState(() {
        _selectCustomer = null;
        _mobileController.clear();
        _purchaseController.clear();
        _paymentTypeController.clear();
      });
    }
  }


  void _pickDate({required bool isFromDate}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorsManager.burgundyColor,
              onPrimary: ColorsManager.whiteColor,
              onSurface: ColorsManager.blackColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ColorsManager.burgundyColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        if (isFromDate) {
          _fromDate = pickedDate;
        } else {
          _toDate = pickedDate;
        }
      });
    }
  }

  void _applyFilter() {
    final filter = {
      'customerName': _selectCustomer,
      'mobile': _selectMobileNumber,
      'purchaseCode': _purchaseController.text,
      'paymentType': _paymentTypeController.text,
      'fromDate': _fromDate,
      'toDate': _toDate,
    };
    Navigator.pop(context, filter);
  }

  void _showPurchaseCodeSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: ColorsManager.whiteColor,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  'Select Purchase Code',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.blackColor, // Title color
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final purchaseCode = customerData.values
                        .map((e) => e['purchaseCode'])
                        .toSet() // Remove duplicates
                        .toList()[index];
                    return ListTile(
                      leading: Icon(
                        Icons.card_giftcard,
                         color: ColorsManager.burgundyColor,
                      ),
                      title: Text(
                        purchaseCode,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorsManager.blackColor
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      onTap: () {
                        setState(() {
                          _purchaseController.text = purchaseCode;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                  separatorBuilder: (context, index) => kSizedBox8,
                  itemCount: customerData.values
                      .map((e) => e['purchaseCode'])
                      .toSet()
                      .length, // Count of unique purchase codes
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPaymentTypeSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: ColorsManager.whiteColor,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  'Select Payment Type',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.blackColor
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final purchaseCode = customerData.values
                        .map((e) => e['paymentType'])
                        .toSet()
                        .toList()[index];
                    return ListTile(
                      leading:  Icon(
                        Icons.payment,
                        color: ColorsManager.burgundyColor,
                      ),
                      title: Text(
                        purchaseCode,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorsManager.blackColor,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      onTap: () {
                        setState(() {
                          _paymentTypeController.text = purchaseCode;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                  separatorBuilder: (context, index) => kSizedBox8,
                  itemCount: customerData.values
                      .map((e) => e['paymentType'])
                      .toSet()
                      .length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }


}

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

  String? _selectCustomer;
  String? _payment;
  DateTime? _fromDate;
  DateTime? _toDate;

  @override
  void dispose() {
    _mobileController.dispose();
    _purchaseController.dispose();
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
              onChanged: updateCustomerDetails),
          kSizedBox15,
          CustomTextField(
            label: 'Mobile Number',
            controller: _mobileController,
            readOnly: true,
          ),
          kSizedBox15,
          CustomTextField(
            label: 'Purchase Code',
            controller: _purchaseController,
            readOnly: true,
          ),
          kSizedBox15,
          const CustomTextWidget(text: 'Payment Type'),
          kSizedBox8,
          CustomDropDownWidget(
            value: _payment,
            items: paymentType.toList(),
            onChanged: (value) {
              setState(() {
                _payment = value;
              });
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
        _mobileController.text = customerData[selectCustomer]!['mobile']!;
        _purchaseController.text =
            customerData[selectCustomer]!['purchaseCode']!;
      });
    } else {
      setState(() {
        _selectCustomer = null;
        _mobileController.clear();
        _purchaseController.clear();
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
      'mobileNumber': _mobileController.text,
      'purchaseCode': _purchaseController.text,
      'paymentType': _payment,
      'fromDate': _fromDate,
      'toDate': _toDate,
    };
    Navigator.pop(context, filter);
  }
}

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final VoidCallback onTap;

  const CustomTextField(
      {super.key,
      required this.label,
      required this.controller,
       required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
        ),
      ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          onTap: onTap,
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF800020),),
                  borderRadius: BorderRadius.circular(12)),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF800020),),
                  borderRadius: BorderRadius.circular(12)),
            ))
      ],
    );
  }
}
// class FilterScreen extends StatefulWidget {
//   const FilterScreen({super.key});
//
//   @override
//   State<FilterScreen> createState() => _FilterScreenState();
// }
//
// class _FilterScreenState extends State<FilterScreen> {
//   final TextEditingController _purchaseController = TextEditingController();
//   final TextEditingController _paymentTypeController = TextEditingController();
//
//   String? _selectCustomer;
//   String? _selectMobileNumber;
//   DateTime? _fromDate;
//   DateTime? _toDate;
//
//   @override
//   void dispose() {
//     _purchaseController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorsManager.whiteColor,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: Text(
//           'Filter',
//           style: TextStyle(
//               color: ColorsManager.blackColor, fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.only(
//           left: 35,
//           right: 35,
//         ),
//         children: [
//           const CustomTextWidget(text: 'Customer Name'),
//           kSizedBox8,
//           CustomDropDownWidget(
//             value: _selectCustomer,
//             items: customerData.keys.toList(),
//             onChanged: (value) {
//               setState(() {
//                 _selectCustomer = value;
//               });
//             },),
//           kSizedBox15,
//           const CustomTextWidget(text: 'Mobile Number'),
//           CustomDropDownWidget(
//             value: _selectMobileNumber,
//             items: customerData.entries
//                 .map((entry) => entry.value['mobile'].toString())
//                 .toList(),
//             onChanged: (value) {
//               setState(() {
//                 _selectMobileNumber = value;
//               });
//             },),
//           kSizedBox15,
//           InkWell(
//             onTap: () {
//               _showPurchaseCodeSelector(context);
//             },
//             child: CustomTextField(
//               label: 'Purchase Code',
//               controller: _purchaseController,
//
//             ),
//           ),
//           kSizedBox15,
//           InkWell(
//             onTap: () {
//               _showPaymentTypeSelector(context);
//             },
//             child: CustomTextField(
//               label: 'Payment Type',
//               controller: _paymentTypeController,
//             ),
//           ),
//
//           kSizedBox15,
//           const CustomTextWidget(text: 'Date Range'),
//           kSizedBox8,
//           Row(
//             children: [
//               Expanded(
//                   child: InkWell(
//                     onTap: () => _pickDate(isFromDate: true),
//                     child: Container(
//                       padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: ColorsManager.burgundyColor,
//                         ),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Text(_fromDate == null
//                           ? 'From'
//                           : '${_fromDate!.day}/${_fromDate!.month}/${_fromDate!.year}'),
//                     ),
//                   )),
//               kSizedBoxW14,
//               Expanded(
//                   child: InkWell(
//                     onTap: () => _pickDate(isFromDate: false),
//                     child: Container(
//                       padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: ColorsManager.burgundyColor,
//                         ),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Text(_toDate == null
//                           ? 'To'
//                           : '${_toDate!.day}/${_toDate!.month}/${_toDate!.year}'),
//                     ),
//                   )),
//             ],
//           ),
//           kSizedBox25,
//           ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: ColorsManager.whiteColor,
//                 backgroundColor: ColorsManager.burgundyColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               onPressed: _applyFilter,
//               child: const CustomTextWidget(text: 'Apply'))
//         ],
//       ),
//     );
//   }
//
//   void updateCustomerDetails(String? selectCustomer) {
//     if (selectCustomer != null && customerData.containsKey(selectCustomer)) {
//       setState(() {
//         _selectCustomer = selectCustomer;
//         // Update the related fields based on the selected customer
//         _purchaseController.text = customerData[selectCustomer]!['purchaseCode'] ?? '';
//         _paymentTypeController.text = customerData[selectCustomer]!['paymentType'] ?? '';
//       });
//     } else {
//       // Clear the fields if no customer is selected
//       setState(() {
//         _selectCustomer = null;
//         _purchaseController.clear();
//         _paymentTypeController.clear();
//       });
//     }
//   }
//
//
//   void _pickDate({required bool isFromDate}) async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.light(
//               primary: ColorsManager.burgundyColor,
//               onPrimary: ColorsManager.whiteColor,
//               onSurface: ColorsManager.blackColor,
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 foregroundColor: ColorsManager.burgundyColor,
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (pickedDate != null) {
//       setState(() {
//         if (isFromDate) {
//           _fromDate = pickedDate;
//         } else {
//           _toDate = pickedDate;
//         }
//       });
//     }
//   }
//
//   void _applyFilter() {
//     final filter = {
//       'customerName': _selectCustomer,
//       'mobileNumber': _selectMobileNumber,
//       'purchaseCode': _purchaseController.text,
//       'paymentType': _paymentTypeController.text,
//       'fromDate': _fromDate,
//       'toDate': _toDate,
//     };
//     Navigator.pop(context, filter); // Send the filter data back
//   }
//
//   void _showPurchaseCodeSelector(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) {
//         return ListView.separated(
//           padding: const EdgeInsets.all(16),
//           itemBuilder: (context, index) {
//             final purchaseCode = customerData.values
//                 .map((e) => e['purchaseCode'])
//                 .toSet() // Remove duplicates
//                 .toList()[index];
//             return ListTile(
//               title: Text(purchaseCode),
//               onTap: () {
//                 setState(() {
//                   _purchaseController.text = purchaseCode;
//                 });
//                 Navigator.pop(context); // Close the modal
//               },
//             );
//           },
//           separatorBuilder: (context, index) => Divider(),
//           itemCount: customerData.values
//               .map((e) => e['purchaseCode'])
//               .toSet()
//               .length, // Count of unique purchase codes
//         );
//       },
//     );
//   }
//   void _showPaymentTypeSelector(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) {
//         return ListView.separated(
//           padding: const EdgeInsets.all(16),
//           itemBuilder: (context, index) {
//             final purchaseCode = customerData.values
//                 .map((e) => e['paymentType'])
//                 .toSet() // Remove duplicates
//                 .toList()[index];
//             return ListTile(
//               title: Text(purchaseCode),
//               onTap: () {
//                 setState(() {
//                   _paymentTypeController.text = purchaseCode;
//                 });
//                 Navigator.pop(context); // Close the modal
//               },
//             );
//           },
//           separatorBuilder: (context, index) => Divider(),
//           itemCount: customerData.values
//               .map((e) => e['paymentType'])
//               .toSet()
//               .length, // Count of unique purchase codes
//         );
//       },
//     );
//   }
//
// }
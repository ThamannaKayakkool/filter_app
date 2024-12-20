import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:filter_app/core/color.dart';
import 'package:filter_app/core/constants.dart';
import 'package:filter_app/screens/all.dart';
import 'package:filter_app/screens/filter_screen.dart';
import 'package:filter_app/screens/name.dart';
import 'package:filter_app/screens/payment_type.dart';
import 'package:filter_app/screens/purchase_code.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> filteredData = customerData.entries
      .map(
        (item) => {
          'name': item.key,
          'mobile': item.value['mobile'],
          'purchaseCode': item.value['purchaseCode'],
          'paymentType': item.value['paymentType'],
          'date': item.value['date'],
        },
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: ColorsManager.whiteColor,
        appBar: AppBar(
          backgroundColor: ColorsManager.whiteColor,
          title: Text(
            'Home',
            style: TextStyle(
                color: ColorsManager.burgundyColor,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  final filter = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FilterScreen(),
                      ));
                  if (filter != null) {
                    _applyFilter(filter);
                  }
                },
                icon: Icon(
                  Icons.sort,
                  color: ColorsManager.burgundyColor,
                ))
          ],
          bottom: ButtonsTabBar(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            backgroundColor: ColorsManager.burgundyColor,
            unselectedBackgroundColor:
                ColorsManager.burgundyColor.withOpacity(0.1),
            unselectedLabelStyle: TextStyle(
              color: ColorsManager.blackColor,
              fontSize: 14,
            ),
            labelStyle: TextStyle(
                color: ColorsManager.whiteColor,
                fontSize: 14,
                fontWeight: FontWeight.w600),
            tabs: const [
              Tab(text: "All"),
              Tab(text: "Name"),
              Tab(text: "PurchaseCode"),
              Tab(text: "PaymentType"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            All(filteredData: filteredData),
            const Name(),
           const PurchaseCode(),
           const PaymentType(),
          ],
        ),
      ),
    );
  }

  void _applyFilter(Map<String, dynamic> filter) {
    setState(() {
      filteredData = customerData.entries
          .where((element) {
            final purchaseCodeMatches =
                (filter['purchaseCode']?.isEmpty ?? true) ||
                    element.value['purchaseCode'] == filter['purchaseCode'];

            final paymentTypeMatches =
                (filter['paymentType']?.isEmpty ?? true) ||
                    element.value['paymentType'] == filter['paymentType'];

            final nameMatches = filter['customerName'] == null ||
                element.key == filter['customerName'];

            final mobileNumberMatches = (filter['mobile']?.isEmpty ?? true) ||
                element.value['mobile'] == filter['mobile'];

            final dateMatches = (filter['fromDate'] == null ||
                    (element.value['date'] as DateTime)
                        .isAfter(filter['fromDate']!)) &&
                (filter['toDate'] == null ||
                    (element.value['date'] as DateTime)
                        .isBefore(filter['toDate']!));

            return nameMatches &&
                mobileNumberMatches &&
                purchaseCodeMatches &&
                paymentTypeMatches &&
                dateMatches;
          })
          .map(
            (item) => {
              'name': item.key,
              'mobile': item.value['mobile'],
              'purchaseCode': item.value['purchaseCode'],
              'paymentType': item.value['paymentType'],
              'date': item.value['date'],
            },
          )
          .toList();
    });
  }
}


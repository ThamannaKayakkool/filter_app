import 'package:filter_app/core/color.dart';
import 'package:filter_app/core/constants.dart';
import 'package:filter_app/screens/filter_screen.dart';
import 'package:filter_app/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> filteredData = customerData.entries
      .map(
        (item) => {
          'name': item.key,
          'mobile': item.value['mobile'],
          'purchaseCode': item.value['purchaseCode'],
        },
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorsManager.burgundyColor,
        title: Text(
          'Home',
          style: TextStyle(
              color: ColorsManager.whiteColor, fontWeight: FontWeight.w600),
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
                color: ColorsManager.whiteColor,
              ))
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            final item = filteredData[index];
            return Card(
                color: ColorsManager.whiteColor,
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: ColorsManager.blackColor)),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: ColorsManager.burgundyColor,
                    child: Text(
                      item['name']?.substring(0, 1)?.toUpperCase() ?? '',
                      style: TextStyle(
                          color: ColorsManager.whiteColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  title: CustomTextWidget(text: item['name']),
                  subtitle: Text(
                    'Mobile Number: ${item['mobile']}\nPurchase Code: ${item['purchaseCode']}',
                    style: TextStyle(
                        color: ColorsManager.blackColor,
                        fontWeight: FontWeight.w400),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: ColorsManager.blackColor,
                    ),
                  ),
                ));
          },
          separatorBuilder: (context, index) {
            return kSizedBox15;
          },
          itemCount: filteredData.length),
    );
  }

  void _applyFilter(Map<String, dynamic> filter) {
    setState(() {
      filteredData = customerData.entries
          .where((element) {
            final nameMatches = filter['customerName'] == null ||
                element.key == filter['customerName'];
            final mobileNumberMatches = filter['mobileNumber']!.isEmpty ||
                element.value['mobile'] == filter['mobileNumber'];
            final purchaseCodeMatches = filter['purchaseCode']!.isEmpty ||
                element.value['purchaseCode'] == filter['purchaseCode'];
            return nameMatches && mobileNumberMatches && purchaseCodeMatches;
          })
          .map(
            (item) => {
              'name': item.key,
              'mobile': item.value['mobile'],
              'purchaseCode': item.value['purchaseCode'],
            },
          )
          .toList();
    });
  }
}

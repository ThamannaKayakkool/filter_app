import 'package:filter_app/core/color.dart';
import 'package:filter_app/core/constants.dart';
import 'package:flutter/material.dart';

class SearchTypeSelectorWidget extends StatelessWidget {
  final String selectedSearchType;
  final ValueChanged<String> onSearchTypeChanged;

  const SearchTypeSelectorWidget({
    required this.selectedSearchType,
    required this.onSearchTypeChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showBottomSheet(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: ColorsManager.oliveGreenColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedSearchType.isEmpty
                  ? 'Select Type'
                  : selectedSearchType,
              style: TextStyle(
                color: selectedSearchType.isEmpty
                    ? ColorsManager.blackColor.withOpacity(0.3)
                    :  ColorsManager.blackColor,
                fontSize: 16
              ),
            ),
           Icon(Icons.arrow_drop_down,color: ColorsManager.oliveGreenColor),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsManager.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Search Type',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.blackColor,
                ),
              ),
              kSizedBox16,
              _buildListTile(
                context,
                icon: Icons.filter_list,
                title: 'All',
                onTap: () => onSearchTypeChanged('All'),
              ),
              _buildListTile(
                context,
                icon: Icons.person,
                title: 'Customer Name',
                onTap: () => onSearchTypeChanged('Customer Name'),
              ),
              _buildListTile(
                context,
                icon: Icons.phone,
                title: 'Mobile Number',
                onTap: () => onSearchTypeChanged('Mobile Number'),
              ),
              _buildListTile(
                context,
                icon: Icons.qr_code,
                title: 'PurchaseCode',
                onTap: () => onSearchTypeChanged('PurchaseCode'),
              ),
              _buildListTile(
                context,
                icon: Icons.payment,
                title: 'PaymentType',
                onTap: () => onSearchTypeChanged('PaymentType'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListTile(BuildContext context,
      {required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        color: ColorsManager.oliveGreenColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: ColorsManager.blackColor,
          fontWeight: FontWeight.bold
        ),
      ),
      onTap: () {
        onTap();
        Navigator.pop(context);
      },
    );}
}
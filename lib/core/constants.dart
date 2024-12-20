
import 'package:flutter/material.dart';

import '../screens/all.dart';

// height

SizedBox kSizedBox4=const SizedBox(
  height: 4,
);SizedBox kSizedBox8=const SizedBox(
  height: 8,
);SizedBox kSizedBox10=const SizedBox(
  height: 10,
);
SizedBox kSizedBox15=const SizedBox(
  height: 15,
);SizedBox kSizedBox16=const SizedBox(
  height: 16,
);
SizedBox kSizedBox20=const SizedBox(
  height: 20,
);SizedBox kSizedBox25=const SizedBox(
  height: 25,
);


// width

SizedBox kSizedBoxW8=const SizedBox(
  width: 8,
);
SizedBox kSizedBoxW14=const SizedBox(
  width: 14,
);
SizedBox kSizedBoxW16=const SizedBox(
  width: 16,
);


final Map<String, dynamic> customerData = {
  'Emily Aysha': {'mobile': '1234567890', 'purchaseCode': 'ABC123', 'paymentType':'Credit Card', 'date': DateTime(2024, 12, 12)},
  'Eflin Aysha': {'mobile': '8987654321', 'purchaseCode': 'SWE564', 'paymentType': 'PhonePe', 'date': DateTime(2024, 12, 20)},
  'Noor Muhammad': {'mobile': '2345078190', 'purchaseCode': 'LMN432', 'paymentType':'UPI', 'date': DateTime(2024, 12, 8)},
  'Ruha Amina': {'mobile': '3456788390', 'purchaseCode': 'QSW0930', 'paymentType':  'GooglePay', 'date': DateTime(2024, 12, 25)},
  'Haya Amina': {'mobile': '1678989001', 'purchaseCode': 'PKM431', 'paymentType': 'Cash on Delivery', 'date': DateTime(2024, 12, 23)},
  'Zainba Zavad': {'mobile': '5678912560', 'purchaseCode': 'GXM367', 'paymentType':'UPI', 'date': DateTime(2024, 12, 14)},
  'Thami': {'mobile': '6788912560', 'purchaseCode': 'GXM367', 'paymentType': 'PhonePe', 'date': DateTime(2024, 12, 19)},
  'Thayi': {'mobile': '2341078190', 'purchaseCode': 'LMN432', 'paymentType':  'Paytm', 'date': DateTime(2024, 12, 1)},
  'Aysha': {'mobile': '3756788390', 'purchaseCode': 'QSW0930', 'paymentType':'Credit Card', 'date': DateTime(2024, 12, 28)},
};
List<String> items = [
  'All',
  'Name',
  'PurchaseCode',
  'PaymentType',
];


import 'package:flutter/material.dart';

// height

SizedBox kSizedBox8=const SizedBox(
  height: 8,
);
SizedBox kSizedBox15=const SizedBox(
  height: 15,
);
SizedBox kSizedBox25=const SizedBox(
  height: 25,
);

// width

SizedBox kSizedBoxW14=const SizedBox(
  width: 14,
);


final Map<String, dynamic> customerData = {
  'Emily Aysha': {'mobile': '1234567890', 'purchaseCode': 'ABC123'},
  'Eflin Aysha': {'mobile': '8987654321', 'purchaseCode': 'SWE564'},
  'Noor Muhammad': {'mobile': '2345078190', 'purchaseCode': 'LMN432'},
  'Ruha Amina': {'mobile': '3456788390', 'purchaseCode': 'QSW0930'},
  'Haya Amina': {'mobile': '1678989001', 'purchaseCode': 'PKM431'},
  'Zainba Zavad': {'mobile': '5678912560', 'purchaseCode': 'GXM367'},
};

final List<String> paymentType = [
  'Cash',
  'Card',
  'UPI',
  'Paytm',
  'PhonePe',
  'GooglePay'
];

import 'package:flutter/material.dart';

class InputWork {
  int? workId;
  DateTime workDateTime;
  TextEditingController workDetailController;
  TextEditingController workMemoController;
  int selectedProductId;
  String productName;

  InputWork({
    this.workId,
    required this.workDateTime,
    required this.workDetailController,
    required this.workMemoController,
    required this.selectedProductId,
    required this.productName,
  });
}

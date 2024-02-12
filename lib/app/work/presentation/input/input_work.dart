import 'package:flutter/material.dart';

class InputWork {
  int? workId;
  DateTime workDateTime;
  TextEditingController workDetailController;
  TextEditingController workMemoController;
  ValueNotifier<int> selectedProductId;

  InputWork({
    this.workId,
    required this.workDateTime,
    required this.workDetailController,
    required this.workMemoController,
    required this.selectedProductId,
  });
}

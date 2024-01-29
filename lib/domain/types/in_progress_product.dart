import 'package:freezed_annotation/freezed_annotation.dart';
part 'in_progress_product.freezed.dart';

@freezed
class InProgressProduct with _$InProgressProduct {
  const factory InProgressProduct(
      {required int id,
      required String productName,
      @Default(0) int isCompleted,
      required DateTime createdOn,
      required String createdBy,
      @Default(null) DateTime? updatedOn,
      @Default(null) String? updatedBy}) = _InProgressProduct;
}

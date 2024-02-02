import 'package:freezed_annotation/freezed_annotation.dart';
part 'in_progress_product.freezed.dart';

@freezed
class InProgressProduct with _$InProgressProduct {
  const factory InProgressProduct(
      {@Default(null) int? id,
      required String productName,
      @Default(null) int? isCompleted,
      @Default(null) DateTime? createdOn,
      @Default(null) String? createdBy,
      @Default(null) DateTime? updatedOn,
      @Default(null) String? updatedBy}) = _InProgressProduct;
}

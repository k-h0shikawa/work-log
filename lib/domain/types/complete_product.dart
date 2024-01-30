import 'package:freezed_annotation/freezed_annotation.dart';
part 'complete_product.freezed.dart';

@freezed
class CompleteProduct with _$CompleteProduct {
  const factory CompleteProduct(
      {@Default(null) int? id,
      required String productName,
      @Default(null) int? isCompleted,
      @Default(null) DateTime? createdOn,
      @Default(null) String? createdBy,
      @Default(null) DateTime? updatedOn,
      @Default(null) String? updatedBy}) = _CompleteProduct;
}

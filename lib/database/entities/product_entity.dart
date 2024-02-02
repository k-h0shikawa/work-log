import 'package:freezed_annotation/freezed_annotation.dart';
part 'product_entity.freezed.dart';

@freezed
class ProductEntity with _$ProductEntity {
  const factory ProductEntity(
      {@Default(null) int? id,
      required String productName,
      @Default(null) int? isCompleted,
      @Default(null) String? createdOn,
      @Default(null) String? createdBy,
      @Default(null) String? updatedOn,
      @Default(null) String? updatedBy}) = _ProductEntity;
}

import 'package:freezed_annotation/freezed_annotation.dart';
part 'product_entity.freezed.dart';

@freezed
class ProductEntity with _$ProductEntity {
  const factory ProductEntity(
      {required int id,
      required String productName,
      required int isCompleted,
      required String createdOn,
      required String createdBy,
      @Default(null) DateTime? updatedOn,
      @Default(null) String? updatedBy}) = _ProductEntity;
}

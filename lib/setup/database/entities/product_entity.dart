import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:work_log/app/domain/entities/in_progress_product.dart';
part 'product_entity.freezed.dart';

@freezed
abstract class ProductEntity implements _$ProductEntity {
  const ProductEntity._();

  const factory ProductEntity(
      {@Default(null) int? id,
      required String productName,
      @Default(null) int? isCompleted,
      @Default(null) String? createdOn,
      @Default(null) String? createdBy,
      @Default(null) String? updatedOn,
      @Default(null) String? updatedBy}) = _ProductEntity;

  InProgressProduct toInProgressProduct() {
    return InProgressProduct(
      id: id,
      productName: productName,
      isCompleted: isCompleted,
      createdOn: createdOn != null ? DateTime.parse(createdOn!) : null,
      createdBy: createdBy,
    );
  }
}

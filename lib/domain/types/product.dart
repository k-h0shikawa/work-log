import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:work_log/domain/types/product.dart';
part 'product.freezed.dart';

@freezed
class Product with _$Product {
  const factory Product(
      {required int id,
      required String productName,
      required int status}) = _Product;
}

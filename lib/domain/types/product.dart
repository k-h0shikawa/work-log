import 'package:freezed_annotation/freezed_annotation.dart';
part 'product.freezed.dart';

@freezed
class Product with _$Product {
  const factory Product(
      {required int id,
      required String productName,
      @Default(false) bool isCompleted}) = _Product;
}

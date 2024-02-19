import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'selected_product_id_notifier.g.dart';

@Riverpod()
class SelectedProductIdNotifier extends _$SelectedProductIdNotifier {
  @override
  int build(int index, {int? productId}) {
    return productId!;
  }

  void updateState(int productId) {
    state = productId;
  }
}

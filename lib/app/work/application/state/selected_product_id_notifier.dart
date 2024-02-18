import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'selected_product_id_notifier.g.dart';

@Riverpod()
class SelectedProductIdNotifier extends _$SelectedProductIdNotifier {
  @override
  int build(int index) {
    return 3;
  }

  void updateState(int productId) {
    state = productId;
  }
}

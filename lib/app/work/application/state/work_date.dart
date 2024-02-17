import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'work_date.g.dart';

@Riverpod()
class WorkDateNotifier extends _$WorkDateNotifier {
  @override
  DateTime build() {
    return DateTime.now();
  }

  void updateState(DateTime dateTime) {
    state = dateTime;
  }
}

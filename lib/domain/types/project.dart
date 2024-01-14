import 'package:freezed_annotation/freezed_annotation.dart';
part 'project.freezed.dart';

@freezed
class Project with _$Project {
  const factory Project(
      {required int id,
      required String projectName,
      required int status}) = _Project;
}

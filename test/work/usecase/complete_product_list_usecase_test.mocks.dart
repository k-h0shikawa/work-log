// Mocks generated by Mockito 5.4.4 from annotations
// in work_log/test/work/usecase/complete_product_list_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:work_log/app/domain/entities/in_progress_product.dart' as _i5;
import 'package:work_log/app/domain/entities/work.dart' as _i4;
import 'package:work_log/app/work/infrastructure/work_list_repository.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [WorkListRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockWorkListRepository extends _i1.Mock
    implements _i2.WorkListRepository {
  @override
  _i3.Future<List<_i4.Work>> fetchWorks(List<int>? workIds) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchWorks,
          [workIds],
        ),
        returnValue: _i3.Future<List<_i4.Work>>.value(<_i4.Work>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i4.Work>>.value(<_i4.Work>[]),
      ) as _i3.Future<List<_i4.Work>>);

  @override
  _i3.Future<List<int>> insertWork(List<_i4.Work>? workList) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertWork,
          [workList],
        ),
        returnValue: _i3.Future<List<int>>.value(<int>[]),
        returnValueForMissingStub: _i3.Future<List<int>>.value(<int>[]),
      ) as _i3.Future<List<int>>);

  @override
  _i3.Future<List<_i5.InProgressProduct>> fetchInProgressProductList() =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchInProgressProductList,
          [],
        ),
        returnValue: _i3.Future<List<_i5.InProgressProduct>>.value(
            <_i5.InProgressProduct>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i5.InProgressProduct>>.value(
                <_i5.InProgressProduct>[]),
      ) as _i3.Future<List<_i5.InProgressProduct>>);
}

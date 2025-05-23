// Mocks generated by Mockito 5.4.5 from annotations
// in fempinya3_flutter_app/test/rondes_presentation_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i3;
import 'package:fempinya3_flutter_app/features/rondes/rondes.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeRondesRepository_0 extends _i1.SmartFake
    implements _i2.RondesRepository {
  _FakeRondesRepository_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [GetPublicDisplayUrl].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPublicDisplayUrl extends _i1.Mock
    implements _i2.GetPublicDisplayUrl {
  @override
  _i2.RondesRepository get repository =>
      (super.noSuchMethod(
            Invocation.getter(#repository),
            returnValue: _FakeRondesRepository_0(
              this,
              Invocation.getter(#repository),
            ),
            returnValueForMissingStub: _FakeRondesRepository_0(
              this,
              Invocation.getter(#repository),
            ),
          )
          as _i2.RondesRepository);

  @override
  _i4.Future<_i3.Either<dynamic, dynamic>> call({
    required _i2.GetPublicDisplayUrlParams? params,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#call, [], {#params: params}),
            returnValue: _i4.Future<_i3.Either<dynamic, dynamic>>.value(
              _FakeEither_1<dynamic, dynamic>(
                this,
                Invocation.method(#call, [], {#params: params}),
              ),
            ),
            returnValueForMissingStub:
                _i4.Future<_i3.Either<dynamic, dynamic>>.value(
                  _FakeEither_1<dynamic, dynamic>(
                    this,
                    Invocation.method(#call, [], {#params: params}),
                  ),
                ),
          )
          as _i4.Future<_i3.Either<dynamic, dynamic>>);
}

// Mocks generated by Mockito 5.4.4 from annotations
// in final_assignment/test/unit_test/profile_test/get_user_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i2;
import 'package:final_assignment/core/failure/failure.dart' as _i6;
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart'
    as _i4;
import 'package:final_assignment/features/profile/presentation/navigator/profile_navigator.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

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

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ProfileNavigator].
///
/// See the documentation for Mockito's code generation for more information.
class MockProfileNavigator extends _i1.Mock implements _i3.ProfileNavigator {
  @override
  void openAppointmentDetail() => super.noSuchMethod(
        Invocation.method(
          #openAppointmentDetail,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void navigateToInsuranceView() => super.noSuchMethod(
        Invocation.method(
          #navigateToInsuranceView,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [UserSharedPrefs].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserSharedPrefs extends _i1.Mock implements _i4.UserSharedPrefs {
  @override
  _i5.Future<_i2.Either<_i6.Failure, bool>> setUserToken(String? token) =>
      (super.noSuchMethod(
        Invocation.method(
          #setUserToken,
          [token],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, bool>>.value(
            _FakeEither_0<_i6.Failure, bool>(
          this,
          Invocation.method(
            #setUserToken,
            [token],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i2.Either<_i6.Failure, bool>>.value(
                _FakeEither_0<_i6.Failure, bool>(
          this,
          Invocation.method(
            #setUserToken,
            [token],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, bool>>);

  @override
  _i5.Future<_i2.Either<_i6.Failure, String>> getUserToken() =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserToken,
          [],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, String>>.value(
            _FakeEither_0<_i6.Failure, String>(
          this,
          Invocation.method(
            #getUserToken,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i2.Either<_i6.Failure, String>>.value(
                _FakeEither_0<_i6.Failure, String>(
          this,
          Invocation.method(
            #getUserToken,
            [],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, String>>);

  @override
  _i5.Future<_i2.Either<_i6.Failure, bool>> removeUserToken() =>
      (super.noSuchMethod(
        Invocation.method(
          #removeUserToken,
          [],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, bool>>.value(
            _FakeEither_0<_i6.Failure, bool>(
          this,
          Invocation.method(
            #removeUserToken,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i2.Either<_i6.Failure, bool>>.value(
                _FakeEither_0<_i6.Failure, bool>(
          this,
          Invocation.method(
            #removeUserToken,
            [],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, bool>>);

  @override
  _i5.Future<_i2.Either<_i6.Failure, bool>> saveFingerPrintId(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveFingerPrintId,
          [id],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, bool>>.value(
            _FakeEither_0<_i6.Failure, bool>(
          this,
          Invocation.method(
            #saveFingerPrintId,
            [id],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i2.Either<_i6.Failure, bool>>.value(
                _FakeEither_0<_i6.Failure, bool>(
          this,
          Invocation.method(
            #saveFingerPrintId,
            [id],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, bool>>);

  @override
  _i5.Future<_i2.Either<_i6.Failure, String>> checkId() => (super.noSuchMethod(
        Invocation.method(
          #checkId,
          [],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, String>>.value(
            _FakeEither_0<_i6.Failure, String>(
          this,
          Invocation.method(
            #checkId,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i2.Either<_i6.Failure, String>>.value(
                _FakeEither_0<_i6.Failure, String>(
          this,
          Invocation.method(
            #checkId,
            [],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, String>>);
}

// Mocks generated by Mockito 5.4.4 from annotations
// in final_assignment/test/unit_test/get_all_doctor_test/doctor_pagination_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i3;
import 'package:final_assignment/core/failure/failure.dart' as _i7;
import 'package:final_assignment/features/favouritedoctors/domain/entity/favourite_entity.dart'
    as _i8;
import 'package:final_assignment/features/favouritedoctors/domain/repository/i_favourite_doctors_repository.dart'
    as _i2;
import 'package:final_assignment/features/favouritedoctors/domain/usecases/favourite_doctors_usecase.dart'
    as _i5;
import 'package:final_assignment/features/home/domain/entity/doctor_entity.dart'
    as _i10;
import 'package:final_assignment/features/home/domain/repository/i_doctor_repository.dart'
    as _i4;
import 'package:final_assignment/features/home/domain/usecases/doctor_usecase.dart'
    as _i9;
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

class _FakeIFavouriteDoctorRepository_0 extends _i1.SmartFake
    implements _i2.IFavouriteDoctorRepository {
  _FakeIFavouriteDoctorRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeIDoctorRepository_2 extends _i1.SmartFake
    implements _i4.IDoctorRepository {
  _FakeIDoctorRepository_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [FavouriteDoctorsUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockFavouriteDoctorsUseCase extends _i1.Mock
    implements _i5.FavouriteDoctorsUseCase {
  MockFavouriteDoctorsUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.IFavouriteDoctorRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeIFavouriteDoctorRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.IFavouriteDoctorRepository);

  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i8.FavouriteEntity>>> call() =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
        ),
        returnValue: _i6
            .Future<_i3.Either<_i7.Failure, List<_i8.FavouriteEntity>>>.value(
            _FakeEither_1<_i7.Failure, List<_i8.FavouriteEntity>>(
          this,
          Invocation.method(
            #call,
            [],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, List<_i8.FavouriteEntity>>>);

  @override
  _i6.Future<_i3.Either<_i7.Failure, bool>> addFavouriteDoctor(
          String? doctorId) =>
      (super.noSuchMethod(
        Invocation.method(
          #addFavouriteDoctor,
          [doctorId],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, bool>>.value(
            _FakeEither_1<_i7.Failure, bool>(
          this,
          Invocation.method(
            #addFavouriteDoctor,
            [doctorId],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, bool>>);

  @override
  _i6.Future<_i3.Either<_i7.Failure, bool>> removeFavouriteDoctor(
          String? doctorId) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeFavouriteDoctor,
          [doctorId],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, bool>>.value(
            _FakeEither_1<_i7.Failure, bool>(
          this,
          Invocation.method(
            #removeFavouriteDoctor,
            [doctorId],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, bool>>);
}

/// A class which mocks [DoctorUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockDoctorUsecase extends _i1.Mock implements _i9.DoctorUsecase {
  MockDoctorUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.IDoctorRepository get doctorRepository => (super.noSuchMethod(
        Invocation.getter(#doctorRepository),
        returnValue: _FakeIDoctorRepository_2(
          this,
          Invocation.getter(#doctorRepository),
        ),
      ) as _i4.IDoctorRepository);

  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i10.DoctorEntity>>>
      getAllDoctors() => (super.noSuchMethod(
            Invocation.method(
              #getAllDoctors,
              [],
            ),
            returnValue: _i6
                .Future<_i3.Either<_i7.Failure, List<_i10.DoctorEntity>>>.value(
                _FakeEither_1<_i7.Failure, List<_i10.DoctorEntity>>(
              this,
              Invocation.method(
                #getAllDoctors,
                [],
              ),
            )),
          ) as _i6.Future<_i3.Either<_i7.Failure, List<_i10.DoctorEntity>>>);

  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i10.DoctorEntity>>> paginateDoctors(
    int? page,
    int? limit,
    String? search,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #paginateDoctors,
          [
            page,
            limit,
            search,
          ],
        ),
        returnValue:
            _i6.Future<_i3.Either<_i7.Failure, List<_i10.DoctorEntity>>>.value(
                _FakeEither_1<_i7.Failure, List<_i10.DoctorEntity>>(
          this,
          Invocation.method(
            #paginateDoctors,
            [
              page,
              limit,
              search,
            ],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, List<_i10.DoctorEntity>>>);
}

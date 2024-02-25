// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_template/common/helpers/dio_helper.dart' as _i7;
import 'package:flutter_template/data/datasources/emergency/emergency_datasource.dart'
    as _i8;
import 'package:flutter_template/data/datasources/place/place_datasource.dart'
    as _i10;
import 'package:flutter_template/data/datasources/user/local/user_datasource.dart'
    as _i6;
import 'package:flutter_template/data/datasources/user/remote/user_datasource.dart'
    as _i12;
import 'package:flutter_template/data/datasources/user/user_datasource.dart'
    as _i13;
import 'package:flutter_template/data/repositories/emergency_repository.dart'
    as _i9;
import 'package:flutter_template/data/repositories/place_repository.dart'
    as _i11;
import 'package:flutter_template/data/repositories/user_repository.dart'
    as _i14;
import 'package:flutter_template/di/modules/local_module.dart' as _i15;
import 'package:flutter_template/di/modules/network_module.dart' as _i16;
import 'package:flutter_template/di/providers/dio_provider.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i5;
import 'package:hive_flutter/hive_flutter.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final localModule = _$LocalModule();
  final networkModule = _$NetworkModule();
  await gh.singletonAsync<_i3.Box<dynamic>>(
    () => localModule.authBox,
    instanceName: 'auth_box',
    preResolve: true,
  );
  gh.lazySingleton<_i4.DioProvider>(
      () => _i4.DioProvider(gh<_i5.Box<dynamic>>(instanceName: 'auth_box')));
  gh.lazySingleton<_i6.UserLocalDataSource>(() => _i6.UserLocalDataSource(
      authBox: gh<_i5.Box<dynamic>>(instanceName: 'auth_box')));
  gh.lazySingleton<_i7.DioHelper>(
      () => networkModule.provideDioHelper(gh<_i4.DioProvider>()));
  gh.lazySingleton<_i8.EmergencyDataSource>(
      () => _i8.EmergencyDataSource(dioHelper: gh<_i7.DioHelper>()));
  gh.lazySingleton<_i9.EmergencyRepository>(
      () => _i9.EmergencyRepository(dataSource: gh<_i8.EmergencyDataSource>()));
  gh.lazySingleton<_i10.PlaceDataSource>(
      () => _i10.PlaceDataSource(dioHelper: gh<_i7.DioHelper>()));
  gh.lazySingleton<_i11.PlaceRepository>(
      () => _i11.PlaceRepository(placeDataSource: gh<_i10.PlaceDataSource>()));
  gh.lazySingleton<_i12.UserRemoteDataSource>(
      () => _i12.UserRemoteDataSource(dioHelper: gh<_i7.DioHelper>()));
  gh.lazySingleton<_i13.UserDataSource>(() => _i13.UserDataSource(
        remoteDataSource: gh<_i12.UserRemoteDataSource>(),
        localDataSource: gh<_i6.UserLocalDataSource>(),
      ));
  gh.lazySingleton<_i14.UserRepository>(
      () => _i14.UserRepository(dataSource: gh<_i13.UserDataSource>()));
  return getIt;
}

class _$LocalModule extends _i15.LocalModule {}

class _$NetworkModule extends _i16.NetworkModule {}

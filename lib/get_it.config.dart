// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:random_user_api/infrastructure/dao/user_dao.dart' as _i3;
import 'package:random_user_api/infrastructure/repositories/user_repository.dart'
    as _i4;
import 'package:random_user_api/register_module.dart' as _i6;
import 'package:random_user_api/view_models/users_view_model.dart' as _i5;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.singletonAsync<String>(
      () => registerModule.dataBasePath(),
      instanceName: 'dataBasePath',
      preResolve: true,
    );
    await gh.singletonAsync<_i3.UserDao>(
      () => registerModule.usersDao(gh<String>(instanceName: 'dataBasePath')),
      instanceName: 'usersDao',
      preResolve: true,
    );
    gh.singleton<_i4.UserRepository>(
        _i4.UserRepository(gh<_i3.UserDao>(instanceName: 'usersDao')));
    gh.singleton<_i5.UserViewModel>(
        _i5.UserViewModel(gh<_i4.UserRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i6.RegisterModule {}

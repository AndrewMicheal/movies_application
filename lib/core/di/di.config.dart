// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/data_sources/login_remote_data_source.dart'
    as _i198;
import '../../features/auth/data/data_sources/login_remote_data_source_impl.dart'
    as _i915;
import '../../features/auth/data/repositories/login_repo_impl.dart' as _i886;
import '../../features/auth/domain/repositories/login_repo.dart' as _i502;
import '../../features/auth/domain/usecases/login_use_case.dart' as _i37;
import '../../features/auth/presentation/cubit/loginScreen/login_cubit.dart' as _i69;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initialize({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i198.LoginRemoteDataSource>(
      () => _i915.LoginRemoteDataSourceImpl(),
    );
    gh.factory<_i502.LoginRepo>(
      () => _i886.LoginRepoImpl(gh<_i198.LoginRemoteDataSource>()),
    );
    gh.factory<_i37.LoginUseCase>(
      () => _i37.LoginUseCase(gh<_i502.LoginRepo>()),
    );
    gh.factory<_i69.LoginCubit>(() => _i69.LoginCubit(gh<_i37.LoginUseCase>()));
    return this;
  }
}

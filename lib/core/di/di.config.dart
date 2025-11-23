// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/data_sources/login_remote_data_source.dart'
    as _i198;
import '../../features/auth/data/data_sources/login_remote_data_source_impl.dart'
    as _i915;
import '../../features/auth/data/repositories/login_repo_impl.dart' as _i886;
import '../../features/auth/domain/repositories/login_repo.dart' as _i502;
import '../../features/auth/domain/usecases/login_use_case.dart' as _i37;
import '../../features/auth/presentation/cubit/loginScreen/login_cubit.dart'
    as _i559;
import '../../features/movie_details/data/data_source/movie_details_data_source.dart'
    as _i524;
import '../../features/movie_details/data/data_source/movie_details_data_source_impl.dart'
    as _i947;
import '../../features/movie_details/data/repository/movie_details_repo_impl.dart'
    as _i1003;
import '../../features/movie_details/domain/repository/movie_details_repo.dart'
    as _i283;
import '../../features/movie_details/presentation/cubit/movie_details_cubit.dart'
    as _i407;
import '../../features/profile/data/datasources/profile_remote_ds.dart'
    as _i320;
import '../../features/profile/data/repo/profile_repository_impl.dart'
    as _i1015;
import '../../features/profile/domain/repos/profile_repo.dart' as _i1007;
import '../../features/profile/domain/usecases/delete_account_use_case.dart'
    as _i954;
import '../../features/profile/domain/usecases/get_profile_use_case.dart'
    as _i525;
import '../../features/profile/domain/usecases/update_profile_use_case.dart'
    as _i540;
import '../../features/profile/presentation/cubit/profile_cubit.dart' as _i36;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initialize({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i320.ProfileRemoteDataSource>(
      () => _i320.ProfileRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.factory<_i198.LoginRemoteDataSource>(
      () => _i915.LoginRemoteDataSourceImpl(),
    );
    gh.factory<_i524.MovieDetailsDataSource>(
      () => _i947.MovieDetailsDataSourceImpl(),
    );
    gh.factory<_i1007.ProfileRepo>(
      () => _i1015.ProfileRepositoryImpl(gh<_i320.ProfileRemoteDataSource>()),
    );
    gh.factory<_i954.DeleteAccountUseCase>(
      () => _i954.DeleteAccountUseCase(gh<_i1007.ProfileRepo>()),
    );
    gh.factory<_i525.GetProfileUseCase>(
      () => _i525.GetProfileUseCase(gh<_i1007.ProfileRepo>()),
    );
    gh.factory<_i540.UpdateProfileUseCase>(
      () => _i540.UpdateProfileUseCase(gh<_i1007.ProfileRepo>()),
    );
    gh.factory<_i283.MovieDetailsRepo>(
      () => _i1003.MovieDetailsRepoImpl(gh<_i524.MovieDetailsDataSource>()),
    );
    gh.factory<_i502.LoginRepo>(
      () => _i886.LoginRepoImpl(gh<_i198.LoginRemoteDataSource>()),
    );
    gh.factory<_i407.MovieDetailsCubit>(
      () => _i407.MovieDetailsCubit(gh<_i283.MovieDetailsRepo>()),
    );
    gh.factory<_i37.LoginUseCase>(
      () => _i37.LoginUseCase(gh<_i502.LoginRepo>()),
    );
    gh.factory<_i36.ProfileCubit>(
      () => _i36.ProfileCubit(
        gh<_i1007.ProfileRepo>(),
        getProfileUseCase: gh<_i525.GetProfileUseCase>(),
        updateProfileUseCase: gh<_i540.UpdateProfileUseCase>(),
        deleteAccountUseCase: gh<_i954.DeleteAccountUseCase>(),
      ),
    );
    gh.factory<_i559.LoginCubit>(
      () => _i559.LoginCubit(gh<_i37.LoginUseCase>()),
    );
    return this;
  }
}

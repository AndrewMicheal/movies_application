import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/features/auth/presentation/screens/forget_password.dart';
import 'package:movies/features/auth/presentation/screens/login.dart';
import 'package:movies/features/auth/presentation/screens/register.dart';
import 'package:movies/features/movies/domain/usecases/get_movies.dart';
import 'package:movies/features/movies/presentation/pages/browse_page.dart';
import 'package:movies/features/movies/presentation/pages/home_page.dart';
import 'package:movies/features/movies/presentation/pages/main_navigation.dart';
import 'package:movies/features/movies/presentation/pages/profile_page.dart';
import 'package:movies/features/movies/presentation/pages/search_page.dart';
import 'package:movies/features/on_boarding_screen/prestentation/screen/on_boarding_screen.dart';
import 'package:movies/l10n/app_localizations.dart';
import 'package:movies/core/app_routes.dart';

import 'features/auth/data/data_sources/auth_remote_data_source.dart';
import 'features/auth/data/data_sources/reset_password_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/data/repositories/reset_password_repository_impl.dart';
import 'features/auth/domain/usecases/register_usecase.dart';

import 'features/auth/domain/usecases/reset_password_usecase.dart';
import 'features/auth/presentation/cubit/registerScreen/register_cubit.dart';
import 'features/auth/presentation/cubit/reset_password/reset_password_cubit.dart';
import 'features/movies/data/data_sources/movies_remote_data_sources.dart';

import 'features/movies/domain/repositories/movie_repository_impl.dart';
import 'features/movies/presentation/cubit/movie_cubit.dart';
import 'features/profile/data/datasources/profile_remote_ds.dart';
import 'features/profile/data/repo/profile_repository_impl.dart';
import 'features/profile/domain/repos/profile_repo.dart';
import 'features/profile/domain/usecases/get_profile_use_case.dart';
import 'features/profile/domain/usecases/update_profile_use_case.dart';
import 'features/profile/presentation/cubit/profile_cubit.dart';

void main() {
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://route-movie-apis.vercel.app",
      validateStatus: (status) => true, // Don't throw exceptions on any status
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  // Optional: Add logging to see what's being sent
  dio.interceptors.add(LogInterceptor(
    request: true,
    requestBody: true,
    responseBody: true,
    error: true,
  ));
  final repo = ProfileRepositoryImpl(ProfileRemoteDataSource(
    dio,
  ));

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>(create: (_) => ProfileCubit(repo, getProfileUseCase: GetProfileUseCase(repo), updateProfileUseCase: UpdateProfileUseCase(repo),),),
        BlocProvider(
          create: (_) => MovieCubit(
            GetMovies(MovieRepositoryImpl(MovieRemoteDataSourceImpl(dio))),
          ),
        ),

        BlocProvider(
          create: (_) => RegisterCubit(
            RegisterUseCase(AuthRepositoryImpl(AuthRemoteDataSource(dio))),
          ),
        ),

        BlocProvider(
          create: (_) => ResetPasswordCubit(
            ResetPasswordUseCase(
              ResetPasswordRepositoryImpl(ResetPasswordRemoteDataSource(dio)),
            ),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: "Movies",
          debugShowCheckedModeBanner: false,
          locale: const Locale("en"),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routes: {
            AppRoutes.onBoardingScreen: (context) => const OnBoardingScreen(),
            AppRoutes.loginScreen: (context) => const LoginScreen(),
            AppRoutes.homeScreen: (context) => const HomeScreen(),
            AppRoutes.searchScreen: (context) => const SearchPage(),
            AppRoutes.browseScreen: (context) => const BrowsePage(),
            AppRoutes.profileScreen: (context) => const ProfilePage(),
            AppRoutes.registerScreen: (context) => const RegisterScreen(),
            AppRoutes.resetPassword: (context) => const ResetPasswordScreen(),
          },
          initialRoute: AppRoutes.onBoardingScreen,
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: widget!,
            );
          },
        );
      },
    );
  }
}

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
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/register_usecase.dart';

import 'features/auth/presentation/cubit/registerScreen/register_cubit.dart';
import 'features/movies/data/data_sources/movies_remote_data_sources.dart';

import 'features/movies/domain/repositories/movie_repository_impl.dart';
import 'features/movies/presentation/cubit/movie_cubit.dart';


void main() {
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  final dio = Dio();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MovieCubit(
            GetMovies(
              MovieRepositoryImpl(
                MovieRemoteDataSourceImpl(dio),
              ),
            ),
          ),
        ),

        BlocProvider(
          create: (_) => RegisterCubit(
            RegisterUseCase(
              AuthRepositoryImpl(
                AuthRemoteDataSource(dio),
              ),
            ),
          ),
        ),
      ],
      child:  MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(
        430,
        932,
      ),
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
            AppRoutes.forgetPassword: (context) => const ForgetPasswordScreen(),
          },
          initialRoute: AppRoutes.registerScreen,
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0),
              ),
              child: widget!,
            );
          },
        );
      },
    );
  }
}
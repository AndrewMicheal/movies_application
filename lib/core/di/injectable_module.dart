// lib/core/di/injectable_module.dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  Dio dio(SharedPreferences prefs) {
    final d = Dio(
      BaseOptions(
        baseUrl: "https://route-movie-apis.vercel.app/",
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        validateStatus: (s) => true,
      ),
    );

    d.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          try {
            final token = prefs.getString('token');
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          } catch (e) {
          }
          return handler.next(options);
        },
      ),
    );

    return d;
  }
}

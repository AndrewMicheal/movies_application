
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/features/auth/data/data_sources/login_remote_data_source.dart';
import 'package:movies/features/auth/data/models/LoginResponse.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@Injectable(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource{
  final Dio dio;
  LoginRemoteDataSourceImpl() : dio = Dio(
    BaseOptions(
      baseUrl: 'https://route-movie-apis.vercel.app/',
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    ),
  )..interceptors.add(PrettyDioLogger(
      requestBody: true,
      error: true,
      responseBody: true
  ));
 @override
  Future<LoginResponse> login(String email, String password) async{
    try{
      final response = await dio.post(
        'auth/login',
        data: {"email": email, "password": password},
      );
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else {
        throw Exception('Login failed with states code ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw Exception('no internet connection');
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('no internet connection');
      } else if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Login Failed ');
      } else {
        throw Exception('Something went wrong');
      }
    }
  }
}
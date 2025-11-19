
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/features/auth/data/data_sources/login_remote_data_source.dart';
import 'package:movies/features/auth/data/models/LoginResponse.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../core/token_storage/token_storage.dart';

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
 Future<LoginResponseModel> login({
   required String email,
   required String password,
 }) async {
   try {
     final response = await dio.post(
       "/auth/login",
       data: {
         "email": email,
         "password": password,
       },
     );

     final result = LoginResponseModel.fromJson(
       response.data as Map<String, dynamic>,
       statusCode: response.statusCode,
     );


     if (result.token.isNotEmpty) {
       await TokenStorage.saveToken(result.token);
       print("TOKEN SAVED: ${result.token}");
     }

     return result;
   } catch (e) {
     // Handle error
     throw Exception("Login failed: $e");
   }
 }}
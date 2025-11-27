
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/features/movie_details/data/data_source/movie_details_data_source.dart';
import 'package:movies/features/movie_details/data/model/MovieDetailsResponse.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@Injectable(as: MovieDetailsDataSource)
class MovieDetailsDataSourceImpl implements MovieDetailsDataSource {
  final Dio dio;

  MovieDetailsDataSourceImpl() : dio = Dio(
    BaseOptions(
      baseUrl: 'https://yts.lt/api/v2/movie_details.json',
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    ),
  )..interceptors.add(PrettyDioLogger(
      requestBody: true,
      error: true,
      responseBody: true
  ));

  @override
  Future<MovieDetailsDto> movieDetails(int? id) async{
    try {
      final response = await dio.post("?movie_id=$id&with_images=true&with_cast=true");
      if(response.statusCode == 200) {
        return MovieDetailsDto.fromJson(response.data['data']['movie']);
      }else {
        throw Exception("Failed to load movie details. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: ${e.toString()}");
    }
  }

}
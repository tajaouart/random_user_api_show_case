import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api.g.dart';

@RestApi(baseUrl: 'https://randomuser.me/api/')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/')
  Future<HttpResponse> getUsers(
    @Query('page') int page,
    @Query('results') int results,
  );
}

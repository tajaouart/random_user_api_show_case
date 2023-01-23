import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../models/user.dart';
import '../error/app_error.dart';
import 'user_api.dart';

@singleton
class UserRepository {
  final ApiClient _userApi;

  UserRepository()
      : _userApi = ApiClient(
          Dio(BaseOptions(contentType: 'application/json')),
        );

  Future<Either<AppError, dynamic>> getUsers({
    required int page,
    required int results,
  }) async {
    var response = await _userApi.getUsers(page, results);
    if (response.response.statusCode == 200) {
      var jsonResponse = response.data;
      List<dynamic> jsonUsers = jsonResponse['results'];
      final result = jsonUsers.map((user) => User.fromJson(user)).toList();
      return Right(result);
    } else {
      return const Left(AppError.apiFetch);
    }
  }
}

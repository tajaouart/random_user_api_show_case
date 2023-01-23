import 'dart:async';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../models/user.dart';
import '../dao/user_dao.dart';
import '../error/app_error.dart';
import '../api/user_api.dart';

/// A singleton class that holds the functionality for fetching Users from the API
@singleton
class UserRepository {
  final ApiClient _userApi;
  final UserDao _usersDao;

  /// Create a new instance of the repository
  UserRepository(
    @Named('usersDao') this._usersDao,
  ) : _userApi = ApiClient(
          Dio(BaseOptions(contentType: 'application/json')),
        );

  /// Returns a list of [User] from the API
  ///
  /// [page] the page number of the users to retrieve
  /// [results] the number of results to retrieve
  Future<Either<AppError, dynamic>> getUsersFromApi({
    required int page,
    required int results,
  }) async {
    try {
      // Fetch the users from the API
      var response = await _userApi
          .getUsers(page, results)
          .timeout(const Duration(seconds: 10));
      if (response.response.statusCode == 200) {
        // Parse the JSON response
        var jsonResponse = response.data;
        List<dynamic> jsonUsers = jsonResponse['results'];
        // Convert the JSON response to a list of User models
        final users = jsonUsers.map((user) {
          return User.fromJson(user);
        }).toList();
        _usersDao.insertAllUsers(users);
        return Right(users);
      } else {
        // Return an error if the API request fails
        return const Left(AppError.apiFetch);
      }
    } catch (e) {
      debugPrint('$runtimeType error while fetching api users $e');
      return const Left(AppError.apiFetch);
    }
  }

  Future<List<User>> getUsersFromLocalDb({
    required int page,
    required int results,
  }) async {
    //Calculate the offset based on the page number and number of results
    final offset = (page - 1) * results;
    // Get all the users from the local database with the specified offset and limit
    return await _usersDao.getAllUsers(offset: offset, limit: results);
  }
}

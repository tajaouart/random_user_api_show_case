import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../models/user.dart';

class UserDao {
  final Database _database;

  final tableName = 'users';

  UserDao(this._database);

  /// Inserts a list of [User]s into the 'users' table in the database.
  /// If a user already exists in the database with the same email, it will not insert the user again.
  Future<void> insertAllUsers(List<User> users) async {
    // Create a transaction
    await _database.transaction((txn) async {
      for (final user in users) {
        // Check if the user already exists in the database
        final exists = await txn.query(
          tableName,
          where: 'email = ?',
          whereArgs: [user.email],
          limit: 1,
        );
        if (exists.isNotEmpty) {
          continue;
        }
        // Insert the user if it doesn't already exist
        await txn.insert(
          'users',
          user.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  /// Fetches a list of [User]s from the 'users' table in the database.
  /// You can pass an [offset] and [limit] to specify the range of users to fetch.
  Future<List<User>> getAllUsers({
    int offset = 0,
    int limit = -1,
  }) async {
    final List<Map<String, dynamic>> jsonArray = await _database.query(
      tableName,
      limit: limit,
      offset: offset,
    );

    return User.fromJsonList(jsonArray);
  }
}

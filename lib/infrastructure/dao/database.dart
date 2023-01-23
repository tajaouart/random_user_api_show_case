import 'package:sqflite/sqflite.dart';

import 'user_dao.dart';

/// A class that manages the connection to the SQLite Database
class AppDatabase {
  final Database _database;

  /// Creates a new instance of the [AppDatabase]
  AppDatabase(this._database);

  /// Get the [UserDao] for the database
  UserDao get usersDao => UserDao(_database);
}

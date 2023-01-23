import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:random_user_api/infrastructure/dao/user_dao.dart';
import 'package:sqflite/sqflite.dart';

import 'infrastructure/dao/database.dart';

@module
abstract class RegisterModule {
  @preResolve
  @singleton
  @Named('dataBasePath')
  Future<String> dataBasePath() {
    return getDatabasesPath();
  }

  @singleton
  @preResolve
  @Named('usersDao')
  Future<UserDao> usersDao(
    @Named('dataBasePath') String databasesPath,
  ) async {
    final db = await openDatabase(
      join(databasesPath, 'users_database.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE users('
          'first_name TEXT,'
          'last_name TEXT,'
          'email TEXT,'
          'large_image TEXT,'
          'medium_image TEXT,'
          'thumbnail TEXT,'
          'PRIMARY KEY (email));',
        );
      },
      version: 1,
    );
    return AppDatabase(db).usersDao;
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:random_user_api/infrastructure/repositories/user_repository.dart';

import '../models/user.dart';
import 'view_model.dart';

part 'users_view_model.freezed.dart';

@freezed
class UserVMState with _$UserVMState {
  const factory UserVMState.initial() = _Initial;

  const factory UserVMState.error() = _Error;

  const factory UserVMState.loading() = _Loading;

  const factory UserVMState.loaded({
    required List<User> users,
    required int currentPage,
    required int resultsNbr,
  }) = _Loaded;
}

@singleton
class UserViewModel extends ViewModel<UserVMState> {
  final UserRepository _userRepository;

  UserViewModel(
    this._userRepository,
  ) : super(const UserVMState.initial()) {
    loadData();
  }

  bool get loading => state.maybeWhen(
        orElse: () => false,
        loading: () => true,
      );

  /// This method loads the data for the view model by fetching the users from the API and the local database
  Future<void> loadData() async {
    changeState(const UserVMState.loading());

    await fetchUsers();
  }

  int get currentPage {
    return state.maybeWhen(
      orElse: () => 1,
      loaded: (_, page, __) {
        return page;
      },
    );
  }

  int get resultsNbr {
    return state.maybeWhen(
      orElse: () => 20,
      loaded: (_, __, results) {
        return results;
      },
    );
  }

  List<User> get users {
    return state.maybeWhen(
      orElse: () => <User>[],
      loaded: (users, __, ___) {
        return users;
      },
    );
  }

  /// This method fetches the users from the API and the local database
  Future<void> fetchUsers() async {
    // First get users from local db if any
    await _getLocalUsers();

    // Now try fetching users from API
    await _getApiUsers();
  }

  /// Fetches users from API.
  Future<void> _getApiUsers() async {
    final remoteUsers = await _userRepository.getUsersFromApi(
      page: currentPage,
      results: resultsNbr,
    );
    return remoteUsers.fold((left) {
      if (users.isEmpty) {
        changeState(const UserVMState.error());
      }
    }, (users) async {
      if (users.isEmpty) {
        if (this.users.isEmpty) {
          changeState(const UserVMState.error());
        }
        return;
      }

      changeState(
        UserVMState.loaded(
          users: users,
          currentPage: currentPage,
          resultsNbr: resultsNbr,
        ),
      );
    });
  }

  /// Gets users that were stored locally.

  Future<void> _getLocalUsers() async {
    final localUsers = await _userRepository.getUsersFromLocalDb(
      page: currentPage,
      results: resultsNbr,
    );

    changeState(
      UserVMState.loaded(
        users: localUsers,
        currentPage: currentPage,
        resultsNbr: resultsNbr,
      ),
    );
  }
}

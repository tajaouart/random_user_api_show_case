import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:random_user_api/infrastructure/api/user_repository.dart';

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

  Future<void> loadData() async {
    changeState(const UserVMState.loading());

    await fetchApiData();
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

  Future<void> fetchApiData() async {
    final result = await _userRepository.getUsers(
      page: currentPage,
      results: resultsNbr,
    );
    return result.fold((left) {
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
}

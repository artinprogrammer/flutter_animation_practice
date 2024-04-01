import 'package:flutter_animation_practice/features/search_feature/data/datasource/user_datasource.dart';
import 'package:flutter_animation_practice/features/search_feature/domain/entity/user.dart';
import 'package:flutter_animation_practice/features/search_feature/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _userDataSource;
  UserRepositoryImpl({required UserDataSource userDataSource})
      : _userDataSource = userDataSource;

  @override
  Future<void> initDB() async {
    await _userDataSource.initDB();
  }

  @override
  List<User> fetchUsers() {
    List<User> users = _userDataSource.fetchUsersData();
    return users;
  }

  @override
  void changeUserIsFollowed(int id) {
    _userDataSource.changeFollowedStatus(id);
  }
}

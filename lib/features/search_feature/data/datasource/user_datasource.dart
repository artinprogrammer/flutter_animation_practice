import 'package:flutter_animation_practice/features/search_feature/domain/entity/user.dart';
import 'package:hive/hive.dart';

abstract class UserDataSource {
  Future<void> initDB();
  List<User> fetchUsersData();
  void changeFollowedStatus(int id);
}

class UserDataSourceImpl implements UserDataSource {
  late Box<User> _users;

  @override
  Future<void> initDB() async {
    _users = await Hive.openBox<User>("users");
  }

  @override
  List<User> fetchUsersData() {
    List<User> users = _users.values.toList();
    return users;
  }

  @override
  void changeFollowedStatus(int id) async {
    User userToChange =
        _users.values.where((user) => user.id == id).toList()[0];
    User newUser = User(
        id: id, name: userToChange.name, isFollowed: !userToChange.isFollowed);
    _users.put(id, newUser);
  }
}

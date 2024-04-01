import '../entity/user.dart';

abstract class UserRepository {
  Future<void> initDB();
  List<User> fetchUsers();
  void changeUserIsFollowed(int id);
}

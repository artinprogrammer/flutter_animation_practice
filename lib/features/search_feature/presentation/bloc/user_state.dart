import 'package:equatable/equatable.dart';
import 'package:flutter_animation_practice/features/search_feature/domain/entity/user.dart';

enum UserStatus { initial, loading, successful, failure }

class UserState extends Equatable {
  const UserState(
      {this.status = UserStatus.initial, this.users = const <User>[]});

  final UserStatus status;
  final List<User> users;

  UserState copyWith({UserStatus? newStatus, List<User>? newUsers}) {
    return UserState(status: newStatus ?? status,users: newUsers ?? users);
  }

  @override
  List get props => [status,users];
}

import 'package:flutter_animation_practice/features/search_feature/domain/repository/user_repository.dart';

class ChangeUserFollowUseCase {
  final UserRepository _userRepository;

  ChangeUserFollowUseCase({required UserRepository userRepository})
      : _userRepository = userRepository;

  void call(int id) {
    _userRepository.changeUserIsFollowed(id);
  }
}

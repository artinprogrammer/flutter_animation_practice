import 'dart:developer';
import 'package:flutter_animation_practice/features/search_feature/domain/entity/user.dart';
import 'package:flutter_animation_practice/features/search_feature/domain/repository/user_repository.dart';

class FetchDataUseCase {
  final UserRepository _userRepository;

  FetchDataUseCase({required UserRepository userRepository})
      : _userRepository = userRepository;

  List<User> call() {
    List<User> response = _userRepository.fetchUsers();
    return response;
  }
}

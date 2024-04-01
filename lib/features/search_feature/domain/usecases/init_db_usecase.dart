import 'package:flutter_animation_practice/features/search_feature/domain/repository/user_repository.dart';

class InitDBUseCase {
  final UserRepository _userRepository;

  InitDBUseCase({required UserRepository userRepository})
      : _userRepository = userRepository;

  Future<void> call() async {
    await _userRepository.initDB();
  }
}

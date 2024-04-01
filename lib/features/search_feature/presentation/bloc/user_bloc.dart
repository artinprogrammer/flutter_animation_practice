import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter_animation_practice/features/search_feature/domain/usecases/change_user_follow_usecase.dart';
import 'package:flutter_animation_practice/features/search_feature/domain/usecases/fetch_data_usecase.dart';
import 'package:flutter_animation_practice/features/search_feature/domain/usecases/init_db_usecase.dart';
import 'package:flutter_animation_practice/features/search_feature/presentation/bloc/user_event.dart';
import 'package:flutter_animation_practice/features/search_feature/presentation/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(
      {required InitDBUseCase initDBUseCase,
      required FetchDataUseCase fetchDataUseCase,
      required ChangeUserFollowUseCase changeUserFollowUseCase})
      : _initDBUseCase = initDBUseCase,
        _fetchDataUseCase = fetchDataUseCase,
        _changeUserFollowUseCase = changeUserFollowUseCase,
        super(const UserState()) {
    on<InitDBEvent>(_initDB);
    on<FetchDataEvent>(_fetchData);
    on<ChangeUserIsFollowedEvent>(_changeUserIsFollowed);
  }

  final InitDBUseCase _initDBUseCase;
  final FetchDataUseCase _fetchDataUseCase;
  final ChangeUserFollowUseCase _changeUserFollowUseCase;

  Future<void> _initDB(InitDBEvent event, Emitter<UserState> emit) async {
    await _initDBUseCase.call();
    add(FetchDataEvent());
  }

  void _fetchData(FetchDataEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(newStatus: UserStatus.loading));
    try {
      final response = _fetchDataUseCase.call();
      if (response.isNotEmpty) {
        emit(state.copyWith(
            newStatus: UserStatus.successful, newUsers: response));
      } else {
        emit(state.copyWith(newStatus: UserStatus.failure));
      }
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(newStatus: UserStatus.failure));
    }
  }

  void _changeUserIsFollowed(
      ChangeUserIsFollowedEvent event, Emitter<UserState> emit) {
    _changeUserFollowUseCase.call(event.userId);
    add(FetchDataEvent());
  }
}

import 'package:flutter_animation_practice/features/search_feature/data/datasource/user_datasource.dart';
import 'package:flutter_animation_practice/features/search_feature/data/repository/user_repository_impl.dart';
import 'package:flutter_animation_practice/features/search_feature/domain/repository/user_repository.dart';
import 'package:flutter_animation_practice/features/search_feature/domain/usecases/change_user_follow_usecase.dart';
import 'package:flutter_animation_practice/features/search_feature/domain/usecases/fetch_data_usecase.dart';
import 'package:flutter_animation_practice/features/search_feature/domain/usecases/init_db_usecase.dart';
import 'package:flutter_animation_practice/features/search_feature/presentation/bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupLocator() {
  //? Datasource
  sl.registerLazySingleton<UserDataSource>(() => UserDataSourceImpl());

  //? Repository
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(userDataSource: sl()));

  //? UseCase
  sl.registerLazySingleton(() => FetchDataUseCase(userRepository: sl()));
  sl.registerLazySingleton(() => InitDBUseCase(userRepository: sl()));
  sl.registerLazySingleton(() => ChangeUserFollowUseCase(userRepository: sl()));

  //? Bloc
  sl.registerFactory(() => UserBloc(
      initDBUseCase: sl(),
      fetchDataUseCase: sl(),
      changeUserFollowUseCase: sl()));
}

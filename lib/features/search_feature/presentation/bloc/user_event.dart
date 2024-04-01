import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  @override
  List get props => [];
}

class InitDBEvent extends UserEvent {}

class FetchDataEvent extends UserEvent {}

class ChangeUserIsFollowedEvent extends UserEvent {
  final int userId;

  ChangeUserIsFollowedEvent({required this.userId});

  @override
  List get props => [userId];
}

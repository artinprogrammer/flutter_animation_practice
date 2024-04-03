import 'package:flutter/material.dart';
import 'package:flutter_animation_practice/features/search_feature/domain/entity/user.dart';
import 'package:flutter_animation_practice/features/search_feature/presentation/bloc/user_bloc.dart';
import 'package:flutter_animation_practice/features/search_feature/presentation/bloc/user_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserItem extends StatefulWidget {
  const UserItem({
    super.key,
    required this.height,
    required this.width,
    required this.currentItem,
  });

  final double height;
  final double width;
  final User currentItem;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late final Animation<double> _animation =
      Tween<double>(begin: 1.0, end: 1.15).animate(_animationController);
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height / 10,
        width: widget.width,
        decoration: const BoxDecoration(
            color: Color(0xff503365),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.currentItem.name,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return GestureDetector(
                    onTap: () {
                      if (_animationController.isCompleted) {
                        _animationController.reverse();
                      } else {
                        _animationController.forward();
                      }
                      BlocProvider.of<UserBloc>(context).add(
                          ChangeUserIsFollowedEvent(
                              userId: widget.currentItem.id));
                    },
                    child: Container(
                      height: widget.height / 20,
                      width: widget.width / 5 * _animation.value,
                      decoration: const BoxDecoration(
                          color: Color(0xff794d98),
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                      child: Center(
                        child: Text(
                          widget.currentItem.isFollowed == false
                              ? "Follow"
                              : "Unfollow",
                          style: const TextStyle(color: Color(0xff0d0811)),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ));
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_animation_practice/features/search_feature/presentation/bloc/user_bloc.dart';
import 'package:flutter_animation_practice/features/search_feature/presentation/bloc/user_event.dart';
import 'package:flutter_animation_practice/features/search_feature/presentation/bloc/user_state.dart';
import 'package:flutter_animation_practice/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var height = size.height;
    var width = size.width;
    double mainPadding = width / 12;
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xff0d0811),
      body: BlocProvider(
          create: (context) => sl<UserBloc>()..add(InitDBEvent()),
          child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
            if (state.status == UserStatus.failure) {
              return const Center(
                child: Text(
                  "Something went wrong! Please try again",
                  style: TextStyle(fontSize: 25),
                ),
              );
            }
            if (state.status == UserStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.status == UserStatus.successful) {
              return SizedBox(
                  height: height,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.users.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var currentItem = state.users[index];
                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                              mainPadding, 16, mainPadding, 0),
                          child: Container(
                              height: height / 10,
                              width: width,
                              decoration: const BoxDecoration(
                                  color: Color(0xff503365),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        currentItem.name,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        BlocProvider.of<UserBloc>(context).add(ChangeUserIsFollowedEvent(userId: currentItem.id));
                                      },
                                      child: Container(
                                        height: height / 20,
                                        width: width / 5,
                                        decoration: const BoxDecoration(
                                          color: Color(0xff794d98),
                                          borderRadius: BorderRadius.all(Radius.circular(24))
                                        ),
                                        child: Center(
                                          child: Text(
                                            currentItem.isFollowed == false ? "Follow" : "Unfollow",
                                            style: const TextStyle(
                                              color: Color(0xff0d0811)
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        );
                      }));
            }
            return Container();
          })),
    ));
  }
}

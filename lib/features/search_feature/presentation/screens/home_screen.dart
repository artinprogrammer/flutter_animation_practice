import 'package:flutter/material.dart';
import 'package:flutter_animation_practice/features/search_feature/presentation/bloc/user_bloc.dart';
import 'package:flutter_animation_practice/features/search_feature/presentation/bloc/user_event.dart';
import 'package:flutter_animation_practice/features/search_feature/presentation/bloc/user_state.dart';
import 'package:flutter_animation_practice/features/search_feature/presentation/widgets/search_box.dart';
import 'package:flutter_animation_practice/features/search_feature/presentation/widgets/user.dart';
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
      body: SingleChildScrollView(
        child: BlocProvider(
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
                return Column(
                  children: [
                    SearchBox(),
                    SizedBox(
                        height: height / 1.25,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.users.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var currentItem = state.users[index];
                              return Padding(
                                padding: EdgeInsets.fromLTRB(
                                    mainPadding, 16, mainPadding, 0),
                                child: UserItem(
                                    height: height,
                                    width: width,
                                    currentItem: currentItem),
                              );
                            })),
                  ],
                );
              }
              return Container();
            })),
      ),
    ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late final Animation<double> _animation =
      Tween<double>(end: 0.0, begin: 1.0).animate(_animationController);
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            width: 50 + (300 * _animation.value),
            height: 60,
            color: _animation.value == 0
                ? Colors.transparent
                : const Color(0xff1b1122),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      if (_animationController.isCompleted) {
                        _animationController.reverse();
                        _focusNode.requestFocus();
                      } else {
                        _animationController.forward();
                      }
                    },
                    icon: Icon(
                      _animation.value == 0
                          ? CupertinoIcons.search
                          : CupertinoIcons.multiply,
                      color: Colors.white,
                      size: 26,
                    )),
                Expanded(
                    child: TextField(
                  focusNode: _focusNode,
                  onTapOutside: (e) {
                    _focusNode.unfocus();
                  },
                ))
              ],
            ),
          );
        });
  }
}

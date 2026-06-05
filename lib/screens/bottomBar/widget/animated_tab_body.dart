import 'package:flutter/material.dart';

class AnimatedTabBody extends StatelessWidget {
  const AnimatedTabBody({
    super.key,
    required this.selectedIndex,
    required this.children,
  });

  final int selectedIndex;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(children.length, (index) {
        final isVisible = selectedIndex == index;
        return IgnorePointer(
          ignoring: !isVisible,
          child: AnimatedOpacity(
            opacity: isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeInOut,
            child: AnimatedSlide(
              offset: isVisible ? Offset.zero : const Offset(0, 0.02),
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutCubic,
              child: children[index],
            ),
          ),
        );
      }),
    );
  }
}

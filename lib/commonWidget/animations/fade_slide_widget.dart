import 'package:flutter/material.dart';

enum SlideDirection {
  bottomToTop,
  topToBottom,
  leftToRight,
  rightToLeft,
}

class FadeSlideWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final SlideDirection direction;
  final Curve curve;

  const FadeSlideWidget({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.direction = SlideDirection.bottomToTop,
    this.curve = Curves.easeOutQuad,
  }) : super(key: key);

  @override
  State<FadeSlideWidget> createState() => _FadeSlideWidgetState();
}

class _FadeSlideWidgetState extends State<FadeSlideWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 1.0, curve: Curves.easeIn)),
    );

    Offset startOffset;
    switch (widget.direction) {
      case SlideDirection.bottomToTop:
        startOffset = const Offset(0.0, 0.2);
        break;
      case SlideDirection.topToBottom:
        startOffset = const Offset(0.0, -0.2);
        break;
      case SlideDirection.leftToRight:
        startOffset = const Offset(-0.2, 0.0);
        break;
      case SlideDirection.rightToLeft:
        startOffset = const Offset(0.2, 0.0);
        break;
    }

    _slideAnimation = Tween<Offset>(begin: startOffset, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );

    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}

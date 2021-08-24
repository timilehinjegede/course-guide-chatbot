library fancy_loader;

import 'dart:ui';

import 'package:flutter/material.dart';

// TODO(timilehinjegede): Add support for size transitions
enum TransitionType { scale, slide, fade, size }

class FancyLoader {
  /// creates a [FancyLoader] widget that is used to create beautiful overlay loading animations.
  const FancyLoader({
    this.duration = const Duration(milliseconds: 750),
    this.transitionType = TransitionType.scale,
    this.loaderTween = const LoaderTween<double>(begin: 0.2, end: 0.8),
    this.blurValue = 4.0,
    this.backgroundColor = Colors.black54,
    this.child,
    this.curve = Curves.easeInOut,
    this.reverseCurve,
  })  : assert(duration != null),
        assert(curve != null),
        assert(loaderTween != null);

  // assert((transitionType == TransitionType.fade && transitionType == TransitionType.scale) || loaderTween is double, "A type loaderTween can't be assigned to a type double"),
  // assert((transitionType == TransitionType.slide) && loaderTween is Offset, "A type loaderTween can't be assigned to a type Offset")

  bool debugAssertIsValid() {
    assert(true == false);
    return false;
  }

  /// The transition to be used for the [FancyLoader] widget.
  ///
  /// Can be either scale, slide, fade or size transitions. Must not be null.
  ///
  /// If [transitionType] is not specified, [TransitionType.scale] is used.
  final TransitionType transitionType;

  /// Used to specify the begin and end values of the animation type used in [TransitionType].
  ///
  /// If [transitionType] is not specified and a [loaderTween] is not provided, a value of 0.2 is used for the begin value and 0.8 is used for end value.
  final LoaderTween<double> loaderTween;

  /// The duration of the animation to be used in [transitionType]
  ///
  /// If [duration] is null, a default of 750 milliseconds is used.
  final Duration duration;

  /// The widget to be passed as a child to the [FancyLoader] widget.
  ///
  /// This is the widget that animates
  final Widget child;

  /// The amount of blur to apply to the background of the [FancyLoader] widget.
  ///
  /// A default value of 4.0 is given if [blurValue] is null.
  final double blurValue;

  /// The background color to be used for the [FancyLoader] widget.
  ///
  /// This is used to fill the back of the [FancyLoader] widget. If null, a default value of Colors.black54 is used.
  final Color backgroundColor;

  /// The curve to be applied to the type of transition in [transitionType]
  final Curve curve;

  /// The reverse curve to be applied to the type os transition in [transitionType]
  ///
  /// If [reverseCurve] is null, [curve] will be used as the value of the [reverseCurve].
  final Curve reverseCurve;

  /// Used to show the [FancyLoader]
  ///
  /// the [show] method is called on the [FancyLoader] to show the [FancyLoader] in your widget tree or apps.
  void show(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierColor: backgroundColor,
      builder: (_) {
        return Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurValue, sigmaY: blurValue),
            child: _FancyLoaderLogic(
              duration: duration,
              transitionType: transitionType,
              child: child,
              blurValue: blurValue,
              backgroundColor: backgroundColor,
              loaderTween: loaderTween,
              curve: curve,
              reverseCurve: reverseCurve,
            ),
          ),
        );
      },
    );
  }

  /// Used to remove the [FancyLoader]
  ///
  /// the [dismiss] method is called on the [FancyLoader] to remove the [FancyLoader] in your widget tree or apps.
  void dismiss(BuildContext context) {
    Navigator.of(context).pop();
  }
}

/// Handles the logic of the [FancyLoader] widget.
class _FancyLoaderLogic extends StatefulWidget {
  const _FancyLoaderLogic(
      {Key key,
      this.duration,
      this.transitionType,
      this.blurValue,
      this.backgroundColor,
      this.child,
      this.loaderTween,
      this.curve,
      this.reverseCurve})
      : super(key: key);

  final Duration duration;
  final TransitionType transitionType;
  final Widget child;
  final double blurValue;
  final Color backgroundColor;
  final LoaderTween<double> loaderTween;
  final Curve curve;
  final Curve reverseCurve;

  @override
  _FancyLoaderLogicState createState() => _FancyLoaderLogicState();
}

class _FancyLoaderLogicState extends State<_FancyLoaderLogic> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  Widget _mapTransitionToWidget() {
    final Widget child = widget.child;

    switch (widget.transitionType) {
      case TransitionType.scale:
        return ScaleTransition(
          scale: _animation,
          child: child,
        );
      case TransitionType.fade:
        return FadeTransition(
          opacity: _animation,
          child: child,
        );
      // TODO(timilehinjegede): add support for size transition
      case TransitionType.size:
        return SizeTransition(
          sizeFactor: null,
          child: child,
        );
      case TransitionType.slide:
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(.0, 2.0), end: const Offset(.0, -2.0)).animate(_animation),
          child: child,
        );
      default:
        return AnimatedContainer(
          duration: widget.duration,
          child: child,
        );
    }
  }

  Tween<dynamic> _mapTransitionToLoaderTween() {
    if (widget.transitionType == TransitionType.fade || widget.transitionType == TransitionType.scale) {
      return Tween<double>(
        begin: widget.loaderTween.begin,
        end: widget.loaderTween.end,
      );
    } else {
      return Tween<Offset>(
        begin: const Offset(.0, .8),
        end: const Offset(.0, -.8),
      );
    }
  }

  // creates an instance of the animation controller and forwards the animation
  @override
  void initState() {
    super.initState();
    // creates an instance of the animation controller
    _controller = AnimationController(vsync: this, duration: widget.duration);
    // creates an instance of the animation
    _animation = Tween<double>(
      begin: widget.loaderTween.begin,
      end: widget.loaderTween.end,
    ).animate(
      CurvedAnimation(
        curve: widget.curve,
        reverseCurve: widget.reverseCurve ?? widget.curve,
        parent: _controller,
      ),
    );

    // forward the controller
    _controller.forward();
    // reverse the controller
    _controller.repeat(reverse: true);
  }

  // disposes and stops the animation controller
  @override
  void dispose() {
    // stop the controller if it is active and the dispose method of the _FancyLoaderLogic is called
    _controller?.stop();
    // dispose the controller
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: _mapTransitionToWidget(),
    );
  }
}

/// Class to hold the start and end values to be used for the scale [TransitionType] provided in the [FancyLoader]
class LoaderTween<T extends dynamic> {
  const LoaderTween({this.begin, this.end});

  final T begin;
  final T end;
}

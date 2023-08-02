import 'package:flutter/material.dart';

class TransparentPageRoute<T> extends PageRoute<T> {
  TransparentPageRoute({
    required this.builder,
    super.settings,
    this.maintainState = true,
    super.fullscreenDialog = true,
    super.allowSnapshotting = true,
  });

  final WidgetBuilder builder;

  @override
  Color? get barrierColor => const Color.fromRGBO(0, 0, 0, 0.6);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  final bool maintainState;

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';

  @override
  String? get barrierLabel => 'close';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    final size = MediaQuery.of(context).size;
    final double paddingValue = (size.width > 600) ? 16 : 0;
    return Padding(
      padding: EdgeInsets.all(paddingValue),
      child: Center(
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(spreadRadius: -5, blurRadius: 16, color: Colors.black.withOpacity(0.1))]),
          child: builder(context),
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return Transform.scale(
      scale: 0.85 + animation.value / (1 / 0.15),
      child: Opacity(
        opacity: animation.value,
        child: child,
      ),
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 100);
}

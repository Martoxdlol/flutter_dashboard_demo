import 'package:flutter/material.dart';

class CardSeeAll extends StatelessWidget {
  const CardSeeAll({super.key, required this.child, this.onSeeMore});

  final Widget child;
  final void Function()? onSeeMore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 4,
              child: child,
            ),
          ),
          if (onSeeMore != null)
            Positioned(
              right: 4,
              top: 4,
              child: IconButton(
                icon: Icon(Icons.fullscreen),
                onPressed: onSeeMore,
              ),
            )
        ],
      ),
    );
  }
}

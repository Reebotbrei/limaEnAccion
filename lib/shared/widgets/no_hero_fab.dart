import 'package:flutter/material.dart';

class NoHeroFloatingActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final ShapeBorder? shape;
  final String? tooltip;
  final bool enableFeedback;
  final double? elevation;

  const NoHeroFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.shape,
    this.tooltip,
    this.enableFeedback = true,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return RawMaterialButton(
          onPressed: onPressed,
          elevation: elevation ?? 6.0,
          fillColor: backgroundColor ?? Theme.of(context).colorScheme.secondary,
          shape: shape ?? const CircleBorder(),
          child: child,
          constraints: const BoxConstraints.tightFor(
            width: 56.0,
            height: 56.0,
          ),
          enableFeedback: enableFeedback,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onPressed;
  final Widget? title;
  final Widget? action;
  final bool hideBackButton;
  final Color? backgroundColor;
  const BasicAppBar({
    super.key,
    required this.onPressed,
    this.title,
    this.action,
    this.hideBackButton = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: title ?? const Text(""),
      leading: hideBackButton
          ? null
          : IconButton.filled(
              onPressed: onPressed,
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.surfaceContainer,
                ),
                foregroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.onSurface,
                ),
              ),
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
              ),
            ),
      actions: [
        action ?? Container(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

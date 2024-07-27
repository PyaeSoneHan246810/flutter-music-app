import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? height;
  const BasicAppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height ?? 72),
      ),
      child: Text(
        text,
      ),
    );
  }
}

import 'package:btk_project/product/extension/context_extesion.dart';
import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize:
            Size(context.dynamicWidth(0.4), context.dynamicHeight(0.07)),
        backgroundColor: Colors.black38,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: context.theme.textTheme.bodyLarge?.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}

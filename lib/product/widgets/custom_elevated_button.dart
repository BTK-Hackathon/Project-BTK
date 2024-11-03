import 'package:btk_project/product/extension/context_extesion.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String textButton;
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.textButton,
  });

  @override
  Widget build(BuildContext context) {
    {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(
            context.dynamicWidth(0.8),
            context.dynamicHeight(0.07),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              width: 1,
              color: Colors.transparent,
            ),
          ),
        ),
        child: Text(textButton),
      );
    }
  }
}

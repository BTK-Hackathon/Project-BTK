import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final bool obscureText; // Add this line
  final TextInputType keyboardType;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.prefixIcon,
    this.suffixIcon,
    required this.onSaved,
    required this.validator,
    this.obscureText = false,
    required this.keyboardType, // Set default to false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText, // Use obscureText here
      onSaved: onSaved,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

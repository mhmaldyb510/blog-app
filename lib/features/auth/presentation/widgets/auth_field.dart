import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final bool isObscureText;
  const AuthField({
    super.key,
    this.hint = '',
    this.controller,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscureText,
      controller: controller,
      decoration: InputDecoration(hintText: hint),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hint';
        }
        return null;
      },
    );
  }
}

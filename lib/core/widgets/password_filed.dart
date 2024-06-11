import 'package:flutter/material.dart';
import 'package:authentication_app/core/gen/fonts.gen.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final String errorPasswordVal;

  const PasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.errorPasswordVal,
    this.onChanged,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isSecurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: _isSecurePassword,
      decoration: InputDecoration(
        errorText:
            widget.errorPasswordVal.isNotEmpty ? widget.errorPasswordVal : null,
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontFamily: FontFamily.circular,
          color: Color(0xFFC1CAD0),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFC1CAD0),
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF24786D),
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _isSecurePassword = !_isSecurePassword;
            });
          },
          icon: _isSecurePassword
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
        ),
      ),
    );
  }
}

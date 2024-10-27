import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    this.validator,
    this.hintText,
    this.obscureText,
    this.onChanged,
    this.controller,
  });

  final String? Function(String?)? validator;
  final String? hintText;
  final bool? obscureText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: TextFormField(
        obscureText: obscureText ?? false,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
            hintStyle: TextStyle(fontSize: 16, color: Colors.blue[900]),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

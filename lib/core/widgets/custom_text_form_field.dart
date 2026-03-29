import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.title,
    this.maxLines = 1,
    this.validator,
    required this.hintText,
    this.isPassword = false,
  });
  final TextEditingController controller;
  final String title;
  final String hintText;
  final int maxLines;
  final Function(String?)? validator;
  final bool isPassword;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isVisible = false;
  late bool _obscureText;
  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: Theme.of(context).textTheme.displaySmall),
        SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: OutlineInputBorder(),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () => togglePasswordVisibility(),
                    icon: _obscureText
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  )
                : null,
          ),

          style: Theme.of(context).textTheme.labelMedium,
          validator: widget.validator != null
              ? (value) => widget.validator!(value!)
              : null,
          obscureText: _obscureText,
        ),
      ],
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:my_stories_app/common/styles.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextInputType textInputType;
  final bool obscure;
  final String errorMessage;
  final TextEditingController textEditingController;

  const CustomTextFormField({
    super.key,
    required this.title,
    required this.hintText,
    required this.textInputType,
    required this.obscure,
    required this.errorMessage,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: myTextTheme.headline6,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          child: Center(
            child: TextFormField(
              controller: textEditingController,
              keyboardType: textInputType,
              obscureText: obscure,
              decoration: InputDecoration.collapsed(hintText: hintText),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return errorMessage;
                }
                return null;
              },
            ),
          ),
        )
      ],
    );
  }
}

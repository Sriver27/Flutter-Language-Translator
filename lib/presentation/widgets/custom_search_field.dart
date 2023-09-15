import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  CustomSearchField({
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Padding(
        padding: EdgeInsets.zero,
        child: TextField(
          style: TextStyle(color: Colors.white),
          cursorHeight: 20,
          cursorColor: Colors.amber,
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white30),
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusColor: Colors.white70,
            hintText: 'Search languages',
            hintStyle: TextStyle(color: Colors.white30),
            prefixIcon: Icon(Icons.search, color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ),
    );
  }
}

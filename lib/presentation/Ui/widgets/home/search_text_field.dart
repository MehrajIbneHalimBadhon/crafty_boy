import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    required this.textEditingController,
  });
  final TextEditingController textEditingController;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.textEditingController,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade200,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(16)),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            errorBorder: const OutlineInputBorder(borderSide: BorderSide.none),
            prefixIcon: const Icon(Icons.search_rounded),
            hintText: 'Search'));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/theme/styles.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FocusNode focusNode;
  final VoidCallback? clearSearchQuery;

  const SearchTextField({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.focusNode,
    required this.clearSearchQuery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      autofocus: false,
      cursorColor: Styles.searchCursorColor,
      textInputAction: TextInputAction.search,
      style: Styles.searchText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        hintText: "Search products",
        fillColor: Styles.searchBackground,
        hintStyle: const TextStyle(fontSize: 14, color: Styles.searchIconColor),
        prefixIcon: const Icon(
          CupertinoIcons.search,
          color: Styles.searchIconColor,
        ),
        suffixIcon: IconButton(
          splashRadius: 20,
          onPressed: clearSearchQuery,
          icon: const Icon(
            CupertinoIcons.clear_thick_circled,
            color: Styles.searchIconColor,
          ),
        ),
      ),
    );
  }
}

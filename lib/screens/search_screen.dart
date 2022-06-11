import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/store/app_store.dart';
import 'package:shopping_app/theme/styles.dart';

import 'widget/product_tile.dart';
import 'widget/search_text_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appStore = context.watch<AppStore>();

    return Scaffold(
      appBar: AppBar(
        title: SearchTextField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: (String? searchTerm) => appStore.searchQuery = searchTerm!,
          clearSearchQuery: () {
            _controller.clear();
            context.read<AppStore>().clearSearchQuery();
          },
        ),
      ),
      body: Observer(
        builder: (context) {
          final products = appStore.search();

          return ListView.separated(
            itemCount: products.length,
            separatorBuilder: (context, index) => const Divider(
              color: Styles.productRowDivider,
              height: 0,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductTile(product: product);
            },
          );
        },
      ),
    );
  }
}

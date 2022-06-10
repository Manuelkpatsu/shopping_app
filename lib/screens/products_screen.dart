import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/store/app_store.dart';
import 'package:shopping_app/theme/styles.dart';

import 'widget/product_tile.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appStore = context.watch<AppStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Store'),
        centerTitle: true,
      ),
      body: Observer(
        builder: (context) {
          return ListView.separated(
            itemCount: appStore.availableProducts.length,
            separatorBuilder: (context, index) => const Divider(
              color: Styles.productRowDivider,
            ),
            itemBuilder: (context, index) {
              final product = appStore.availableProducts[index];
              return ProductTile(product: product);
            },
          );
        },
      ),
    );
  }
}

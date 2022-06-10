import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/store/app_store.dart';
import 'package:shopping_app/theme/styles.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          productThumbnail(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  productName(),
                  const SizedBox(height: 8),
                  productPrice(),
                ],
              ),
            ),
          ),
          addToFavoriteButton(context),
        ],
      ),
    );
  }

  Widget productThumbnail() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Image.asset(
        product.assetName,
        package: product.assetPackage,
        fit: BoxFit.cover,
        width: 80,
        height: 80,
      ),
    );
  }

  Widget productName() {
    return Text(
      product.name,
      style: Styles.productRowItemName,
    );
  }

  Widget productPrice() {
    return Text(
      'Ghs${product.price.toStringAsFixed(2)}',
      style: Styles.productRowItemPrice,
    );
  }

  Widget addToFavoriteButton(BuildContext context) {
    return IconButton(
      splashRadius: 20,
      onPressed: () => context.read<AppStore>().addProductToCart(product.id),
      icon: const Icon(CupertinoIcons.shopping_cart),
    );
  }
}

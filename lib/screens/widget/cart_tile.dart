import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/store/app_store.dart';
import 'package:shopping_app/theme/styles.dart';

import 'custom_icon_button.dart';

class CartTile extends StatelessWidget {
  final Product product;
  final int quantity;

  const CartTile({
    Key? key,
    required this.product,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          productThumbnail(),
          const SizedBox(width: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      productName(),
                      const SizedBox(height: 4),
                      productQuantity(),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    productPrice(),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconButton(
                          icon: Icons.add,
                          onTap: () => context
                              .read<AppStore>()
                              .addProductToCart(product.id),
                        ),
                        const SizedBox(width: 5),
                        quantityText(),
                        const SizedBox(width: 5),
                        CustomIconButton(
                          icon: Icons.remove,
                          onTap: () => context
                              .read<AppStore>()
                              .removeProductFromCart(product.id),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
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
        width: 50,
        height: 50,
      ),
    );
  }

  Widget productName() {
    return Text(
      product.name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Styles.productRowItemName,
    );
  }

  Widget productPrice() {
    return Text(
      'Ghs${(quantity * product.price).toStringAsFixed(2)}',
      style: Styles.productRowItemPrice,
    );
  }

  Widget productQuantity() {
    return Text(
      '${quantity > 1 ? '$quantity x ' : ''}'
      'Ghs${product.price.toStringAsFixed(2)}',
      style: Styles.productRowItemPrice,
    );
  }

  Widget quantityText() {
    return Container(
      alignment: Alignment.center,
      height: 40,
      width: 30,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.blue,
      ),
      child: Text(
        quantity.toString(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

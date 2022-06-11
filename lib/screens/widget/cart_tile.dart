import 'package:flutter/material.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/theme/styles.dart';

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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      productName(),
                      productPrice(),
                    ],
                  ),
                  const SizedBox(height: 4),
                  productQuantity(),
                ],
              ),
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
}

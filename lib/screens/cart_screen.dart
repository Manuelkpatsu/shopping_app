import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/dialogs/clear_cart_dialog.dart';
import 'package:shopping_app/store/app_store.dart';
import 'package:shopping_app/theme/styles.dart';

import 'widget/cart_tile.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final appStore = context.watch<AppStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        centerTitle: true,
      ),
      body: Observer(
        builder: (context) {
          if (appStore.hasItemsInCart) {
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: appStore.productsInCart.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: Styles.productRowDivider,
                      height: 0,
                    ),
                    itemBuilder: (context, index) {
                      final cartMaps = appStore.productsInCart;
                      return CartTile(
                        product: appStore.getProductById(
                          cartMaps.keys.toList()[index],
                        ),
                        quantity: cartMaps.values.toList()[index],
                      );
                    },
                  ),
                ),
                const Divider(height: 0),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          shippingCost(appStore.shippingCost),
                          const SizedBox(height: 6),
                          tax(appStore.tax),
                          const SizedBox(height: 6),
                          totalCost(appStore.totalCost),
                        ],
                      ),
                      clearCartButton(),
                    ],
                  ),
                )
              ],
            );
          } else {
            return emptyCart();
          }
        },
      ),
    );
  }

  Widget emptyCart() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            CupertinoIcons.shopping_cart,
            color: Color(0xFF8E8E93),
            size: 50,
          ),
          SizedBox(height: 5),
          Text(
            'Cart is empty.\nAdd some products to the cart',
            textAlign: TextAlign.center,
            style: Styles.productRowItemName,
          ),
        ],
      ),
    );
  }

  Widget shippingCost(double shippingCost) {
    return Text(
      'Shipping: Ghs${shippingCost.toStringAsFixed(2)}',
      style: Styles.productRowItemPrice,
    );
  }

  Widget tax(double tax) {
    return Text(
      'Tax: Ghs${tax.toStringAsFixed(2)}',
      style: Styles.productRowItemPrice,
    );
  }

  Widget totalCost(double totalCost) {
    return Text(
      'Total: Ghs${totalCost.toStringAsFixed(2)}',
      style: Styles.productRowTotal,
    );
  }

  Widget clearCartButton() {
    return ElevatedButton(
      onPressed: () async {
        final shouldDeleteReminder = await showClearCartDialog(context);
        if (shouldDeleteReminder) {
          context.read<AppStore>().clearCart();
        }
      },
      child: const Text('Clear Cart'),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        onPrimary: Colors.white,
      ),
    );
  }
}

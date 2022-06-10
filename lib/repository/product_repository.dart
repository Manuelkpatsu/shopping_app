import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shopping_app/model/product.dart';

class ProductRepository {
  ProductRepository();

  Future<List<Product>> getProducts(Category category) async {
    String jsonString = await rootBundle.loadString('data/product.json');
    List<dynamic> decodedJson = json.decode(jsonString);

    if (category == Category.all) {
      return decodedJson
          .map((productJson) => Product.fromJson(productJson))
          .toList();
    } else {
      return decodedJson
          .map((productJson) => Product.fromJson(productJson))
          .where((product) => product.category == category)
          .toList();
    }
  }

  Future<Product> getProduct(int id) async {
    String jsonString = await rootBundle.loadString('data/product.json');
    List<dynamic> decodedJson = json.decode(jsonString);

    List<Product> productList = decodedJson
        .map((productJson) => Product.fromJson(productJson))
        .where((product) => product.id == id)
        .toList();

    return productList[0];
  }
}

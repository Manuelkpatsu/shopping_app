enum Category {
  all,
  accessories,
  clothing,
  home,
}

class Product {
  final Category category;
  final int id;
  final bool isFeatured;
  final String name;
  final int price;

  Product({
    required this.id,
    required this.category,
    required this.isFeatured,
    required this.name,
    required this.price,
  });

  Product.fromJson(Map<String, dynamic> json)
      : id = json['name'],
        category = Product.parse(json['category']),
        isFeatured = json['isFeatured'],
        name = json['name'],
        price = json['price'];

  String get assetName => '$id-0.jpg';
  String get assetPackage => 'shrine_images';

  static Category parse(String value) {
    switch (value) {
      case 'accessories':
        return Category.accessories;
      case 'clothing':
        return Category.clothing;
      case 'home':
        return Category.home;
      case 'all':
      default:
        return Category.all;
    }
  }
}

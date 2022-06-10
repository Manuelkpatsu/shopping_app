import 'package:mobx/mobx.dart';
import 'package:shopping_app/model/product.dart';
import 'package:shopping_app/repository/product_repository.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  final ProductRepository _repository;

  _AppStore(this._repository);

  final double _salesTaxRate = 0.06;
  final double _shippingCostPerItem = 7;

  @observable
  bool isLoading = false;

  // The currently selected category of products.
  @observable
  Category selectedCategory = Category.all;

  // All the available products.
  @observable
  ObservableList<Product> availableProducts = ObservableList<Product>();

  // The IDs and quantities of products currently in the cart.
  @observable
  ObservableMap<int, int> productsInCart = ObservableMap<int, int>();

  // Total number of items in the cart.
  @computed
  int get totalCartQuantity {
    return productsInCart.values.fold(0, (accumalator, value) {
      return accumalator + value;
    });
  }

  // Totaled prices of the items in the cart.
  @computed
  double get subtotalCost {
    return productsInCart.keys.map((id) {
      return availableProducts[id].price * productsInCart[id]!;
    }).fold(0, (accumulator, extendedPrice) {
      return accumulator + extendedPrice;
    });
  }

  // Total shipping cost for the items in the cart.
  @computed
  double get shippingCost {
    return _shippingCostPerItem *
        productsInCart.values.fold(0, (accumulator, itemCount) {
          return accumulator + itemCount;
        });
  }

  // Sales tax for the items in the cart
  double get tax => subtotalCost * _salesTaxRate;

  // Total cost to order everything in the cart.
  double get totalCost => subtotalCost + shippingCost + tax;

  // Loads the list of available products from the repo.
  @action
  Future<void> loadProducst() async {
    isLoading = true;
    final products = await _repository.getProducts(selectedCategory);
    availableProducts = ObservableList.of(products);
    isLoading = false;
  }

  // Search the product catalog
  @action
  void search(String searchTerm) {
    availableProducts.where((product) {
      return product.name.toLowerCase().contains(searchTerm.toLowerCase());
    }).toList();
  }

  // Returns the Product instance matching the provided id.
  @action
  Future<Product> getProductById(int id) async {
    return availableProducts.firstWhere((product) => product.id == id);
  }

  // Adds a product to the cart.
  @action
  void addProductToCart(int productId) {
    if (!productsInCart.containsKey(productId)) {
      productsInCart[productId] = 1;
    } else {
      productsInCart[productId]! + 1;
    }
  }

  // Removes an item from the cart.
  @action
  void removeProductFromCart(int productId) {
    if (productsInCart.containsKey(productId)) {
      if (productsInCart[productId] == 1) {
        productsInCart.remove(productId);
      } else {
        productsInCart[productId]! - 1;
      }
    }
  }

  // Removes everything from the cart.
  @action
  void clearCart() => productsInCart.clear();

  @action
  void setCategory(Category newCategory) => selectedCategory = newCategory;
}

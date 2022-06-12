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
  int currentPageIndex = 0;

  @observable
  String searchQuery = '';

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

  @computed
  List<Product> get copyOfProducts {
    if (availableProducts.isEmpty) {
      return [];
    }

    if (selectedCategory == Category.all) {
      return List.from(availableProducts);
    } else {
      return availableProducts.where((p) {
        return p.category == selectedCategory;
      }).toList();
    }
  }

  @computed
  bool get hasItemsInCart {
    return productsInCart.isNotEmpty;
  }

  List<Product> search() {
    return copyOfProducts.where((product) {
      return product.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  bool isInCart(int productId) => productsInCart.containsKey(productId);

  @action
  void clearSearchQuery() {
    searchQuery = '';
  }

  @action
  Future<void> initialize() async {
    isLoading = true;
    await _loadProducts();
    isLoading = false;
  }

  // Loads the list of available products from the repo.
  @action
  Future<void> _loadProducts() async {
    final products = await _repository.getProducts(selectedCategory);
    availableProducts = ObservableList.of(products);
  }

  // Returns the Product instance matching the provided id.
  @action
  Product getProductById(int id) {
    return availableProducts.firstWhere((product) => product.id == id);
  }

  // Adds a product to the cart.
  @action
  void addProductToCart(int productId) {
    if (!productsInCart.containsKey(productId)) {
      productsInCart[productId] = 1;
    } else {
      productsInCart[productId] = productsInCart[productId]! + 1;
    }
  }

  // Removes an item from the cart.
  @action
  void removeProductFromCart(int productId) {
    if (productsInCart.containsKey(productId)) {
      if (productsInCart[productId] == 1) {
        productsInCart.remove(productId);
      } else {
        productsInCart[productId] = productsInCart[productId]! - 1;
      }
    }
  }

  // Removes everything from the cart.
  @action
  void clearCart() => productsInCart.clear();

  @action
  void setCategory(Category newCategory) => selectedCategory = newCategory;

  @action
  void changePage(int index) => currentPageIndex = index;
}

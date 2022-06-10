// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on _AppStore, Store {
  Computed<int>? _$totalCartQuantityComputed;

  @override
  int get totalCartQuantity => (_$totalCartQuantityComputed ??= Computed<int>(
          () => super.totalCartQuantity,
          name: '_AppStore.totalCartQuantity'))
      .value;
  Computed<double>? _$subtotalCostComputed;

  @override
  double get subtotalCost =>
      (_$subtotalCostComputed ??= Computed<double>(() => super.subtotalCost,
              name: '_AppStore.subtotalCost'))
          .value;
  Computed<double>? _$shippingCostComputed;

  @override
  double get shippingCost =>
      (_$shippingCostComputed ??= Computed<double>(() => super.shippingCost,
              name: '_AppStore.shippingCost'))
          .value;

  late final _$isLoadingAtom =
      Atom(name: '_AppStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$selectedCategoryAtom =
      Atom(name: '_AppStore.selectedCategory', context: context);

  @override
  Category get selectedCategory {
    _$selectedCategoryAtom.reportRead();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(Category value) {
    _$selectedCategoryAtom.reportWrite(value, super.selectedCategory, () {
      super.selectedCategory = value;
    });
  }

  late final _$availableProductsAtom =
      Atom(name: '_AppStore.availableProducts', context: context);

  @override
  ObservableList<Product> get availableProducts {
    _$availableProductsAtom.reportRead();
    return super.availableProducts;
  }

  @override
  set availableProducts(ObservableList<Product> value) {
    _$availableProductsAtom.reportWrite(value, super.availableProducts, () {
      super.availableProducts = value;
    });
  }

  late final _$productsInCartAtom =
      Atom(name: '_AppStore.productsInCart', context: context);

  @override
  ObservableMap<int, int> get productsInCart {
    _$productsInCartAtom.reportRead();
    return super.productsInCart;
  }

  @override
  set productsInCart(ObservableMap<int, int> value) {
    _$productsInCartAtom.reportWrite(value, super.productsInCart, () {
      super.productsInCart = value;
    });
  }

  late final _$loadProducstAsyncAction =
      AsyncAction('_AppStore.loadProducst', context: context);

  @override
  Future<void> loadProducst() {
    return _$loadProducstAsyncAction.run(() => super.loadProducst());
  }

  late final _$getProductByIdAsyncAction =
      AsyncAction('_AppStore.getProductById', context: context);

  @override
  Future<Product> getProductById(int id) {
    return _$getProductByIdAsyncAction.run(() => super.getProductById(id));
  }

  late final _$_AppStoreActionController =
      ActionController(name: '_AppStore', context: context);

  @override
  void search(String searchTerm) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.search');
    try {
      return super.search(searchTerm);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addProductToCart(int productId) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.addProductToCart');
    try {
      return super.addProductToCart(productId);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeProductFromCart(int productId) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.removeProductFromCart');
    try {
      return super.removeProductFromCart(productId);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearCart() {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.clearCart');
    try {
      return super.clearCart();
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCategory(Category newCategory) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setCategory');
    try {
      return super.setCategory(newCategory);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
selectedCategory: ${selectedCategory},
availableProducts: ${availableProducts},
productsInCart: ${productsInCart},
totalCartQuantity: ${totalCartQuantity},
subtotalCost: ${subtotalCost},
shippingCost: ${shippingCost}
    ''';
  }
}

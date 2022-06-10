import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'repository/product_repository.dart';
import 'screens/main_screen.dart';
import 'store/app_store.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    Provider(
      create: (_) => AppStore(ProductRepository())..initialize(),
      child: const MainScreen(),
    ),
  );
}

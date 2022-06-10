import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/store/app_store.dart';

import 'cart_screen.dart';
import 'products_screen.dart';
import 'search_screen.dart';
import 'widget/loading/loading_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: ReactionBuilder(
        builder: (context) {
          return autorun((_) {
            final isLoading = context.read<AppStore>().isLoading;
            if (isLoading) {
              LoadingScreen.instance().show(
                context: context,
                text: 'Loading...',
              );
            } else {
              LoadingScreen.instance().hide();
            }
          });
        },
        child: Observer(
          builder: (context) {
            final appStore = context.watch<AppStore>();
            return Scaffold(
              body: SafeArea(
                child: IndexedStack(
                  index: appStore.currentPageIndex,
                  children: const [
                    ProductsScreen(),
                    SearchScreen(),
                    CartScreen(),
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                elevation: 5,
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                currentIndex: appStore.currentPageIndex,
                onTap: (index) => context.read<AppStore>().changePage(index),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home),
                    label: 'Products',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.search),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.shopping_cart),
                    label: 'Cart',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

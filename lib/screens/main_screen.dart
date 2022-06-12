import 'package:badges/badges.dart';
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
    final appStore = context.read<AppStore>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(elevation: 0.0),
      ),
      home: ReactionBuilder(
        builder: (context) {
          return autorun((_) {
            // handle loading screen
            if (appStore.isLoading) {
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
            return Scaffold(
              body: IndexedStack(
                index: appStore.currentPageIndex,
                children: const [
                  ProductsScreen(),
                  SearchScreen(),
                  CartScreen(),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                elevation: 5,
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                currentIndex: appStore.currentPageIndex,
                onTap: (index) => appStore.changePage(index),
                items: [
                  const BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home),
                    label: 'Products',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.search),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Badge(
                      toAnimate: false,
                      badgeContent: Text(
                        appStore.totalCartQuantity.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      child: const Icon(CupertinoIcons.shopping_cart),
                    ),
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

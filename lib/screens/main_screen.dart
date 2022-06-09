import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cart_screen.dart';
import 'products_screen.dart';
import 'search_screen.dart';

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
      home: Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: 0,
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
          currentIndex: 0,
          onTap: (index) {},
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
      ),
    );
  }
}

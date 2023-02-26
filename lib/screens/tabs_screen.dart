import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meal_app/widgets/main_drawer.dart';
import './categories_screen.dart';
import './favorites_screen.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  List<Meal> favoriteMeal;
  TabsScreen(this.favoriteMeal);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Widget> _pages = [];
  int _selectedIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [CategoriesScreen(), FavoritesScreen(widget.favoriteMeal)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meaaly'),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber,
        selectedIconTheme: IconThemeData(size: 30),
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.shifting,
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}







/* 
----> Adding Tab below the APPBAR
DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Meaaly'),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.category),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favorites',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CategoriesScreen(),
            FavoritesScreen(),
          ],
        ),
      ),
    );
    
  */
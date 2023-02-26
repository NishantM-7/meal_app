import 'package:flutter/material.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meal_screen.dart';
import './screens/categories_screen.dart';
import './screens/filters_screen.dart';
import './dummy_data.dart';
import './models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex = _favoriteMeals.indexWhere((meal) {
      return meal.id == mealId;
    });

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meaaly',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        appBarTheme: ThemeData.light().appBarTheme.copyWith(
                titleTextStyle: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 20,
            )),
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            headline6: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      //  home: TabsScreen(),
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        '/category-meals': (ctx) => MealScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters)
      },
    );
  }
}




//NOTE1:
// OnGenerateRoute is used to navigate to any page which is not registered in the routes table but we have provided a InkWell to navigate.
//It so navigates to the page given in the onGenerateRoute. 
// onUnknownRoute is reached when Flutter fails to build a screen with all other measures.
// onGenerateRoute: (settings) {
//         print(settings.arguments);
//         return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
//       },
// onUnknownRoute: (settings) {
//         print(settings.arguments);
//         return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
//       },







//NOTE2:
// initialRoute: '#',
      //Intial Route is '/' by default but can be changed...
      // after setting initial route to '#' use '#category-meals':(ctx) => MealScreen()




//NOTE3:
// USing '/category-meals': (ctx) => MealScreen() may sometimes cause typo mistakes
// So instead declare a static constant variable in the MealScreen which will hold the Route name
// for e.g. static const routeName = '/category-meals'
//then use it in the routes table and Navigator.of() as follows:
// ->   MealScreen.routeName: (ctx) => MealScreen()
//->  Navigator.of(context).pushNamed(  MealScreen.routeName , arguments: ....code)

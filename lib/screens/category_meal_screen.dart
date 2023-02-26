import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class MealScreen extends StatefulWidget {
  final List<Meal> availableMeals;
  MealScreen(this.availableMeals);
  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  // final String categoryId;          // Used in passing data through constructor approach while using material page route
  String? categoryTitle;
  List<Meal>? displayedMeals;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    displayedMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals!.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle as String),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals![index].id,
            title: displayedMeals![index].title,
            imageUrl: displayedMeals![index].imageUrl,
            duration: displayedMeals![index].duration,
            complexity: displayedMeals![index].complexity,
            affordability: displayedMeals![index].affordability,
          );
        },
        itemCount: displayedMeals!.length,
      ),
    );
  }
}

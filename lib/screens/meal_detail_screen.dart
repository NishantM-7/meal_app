import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavoriteFunc;

  MealDetailScreen(this.toggleFavorite, this.isFavoriteFunc);

  Widget buildSectioTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      height: 150,
      width: double.infinity,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) {
      return meal.id == mealId;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectioTitle(context, 'Ingredients'),
            buildContainer(
                child: ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  color: Theme.of(context).primaryColor,
                  shadowColor: Theme.of(context).canvasColor,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Text(
                      selectedMeal.ingredients[index],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
              itemCount: selectedMeal.ingredients.length,
            )),
            buildSectioTitle(context, 'Steps'),
            buildContainer(
                child: ListView.builder(
              itemBuilder: ((context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${index + 1}'),
                      ),
                      title: Text(selectedMeal.steps[index]),
                    ),
                    Divider(
                      color: Colors.pink,
                      indent: 70,
                    )
                  ],
                );
              }),
              itemCount: selectedMeal.steps.length,
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavorite(mealId),
        child:
            isFavoriteFunc(mealId) ? Icon(Icons.star) : Icon(Icons.star_border),
      ),
    );
  }
}

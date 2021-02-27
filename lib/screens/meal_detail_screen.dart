import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = 'meal_detail';
  final Function toggleFavorites;
  final Function isFavorites;

  MealDetailScreen( this.toggleFavorites, this.isFavorites);

  Widget buildSectionItem(String text,BuildContext ctx){
    return          Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(ctx).textTheme.headline6,
      ),
    );
  }
  Widget buildContainer  (Widget child ){
    return  Container(
      decoration: BoxDecoration(
          color:Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)
      ),
      margin:EdgeInsets.all(10),
      padding:EdgeInsets.all(10),
      height: 150,
      width: 350,
      child: child,
    );


  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
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
            buildSectionItem('Ingredients', context),
            buildContainer(ListView.builder(
              itemBuilder: (ctx,index)=> Card(
                color: Theme.of(context).accentColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                  child: Text(
                      selectedMeal.ingredients[index]
                  ),
                ),
              ),
              itemCount: selectedMeal.ingredients.length,
            )),
            buildSectionItem('Steps', context),
            buildContainer(ListView.builder(
              itemBuilder: (ctx,index)=> Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text("# ${index+1}"),
                    ),
                    title: Text(selectedMeal.steps[index]),
                  ),
                  Divider(),
                ],
              ),
              itemCount: selectedMeal.steps.length,
            ))

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>toggleFavorites(mealId),
        child:
        Icon(isFavorites(mealId)? Icons.star:Icons.star_border),
      ),
    );
  }
}

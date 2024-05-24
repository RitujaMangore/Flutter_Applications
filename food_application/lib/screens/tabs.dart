import 'package:flutter/material.dart';
import 'package:food_application/data/dummy_data.dart';
import 'package:food_application/screens/categories.dart';
import 'package:food_application/screens/filter.dart';
import 'package:food_application/screens/meals.dart';
import 'package:food_application/widgets/main_drawer.dart';

import '../models/meal.dart';

const kInitialFilters = {
  Filter.glutenFree : false,
  Filter.lactoseFree : false,
  Filter.vegetarian : false,
  Filter.vegan : false,
};

class TabsScreens extends StatefulWidget{
  const TabsScreens({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreens>{
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> selectedFilters = kInitialFilters;
  int _selectPageIndex = 0;

  void _showInfoMessage(String message){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }


  void _toggleMealFavoriteStatus(Meal meal){
    final isExisting = _favoriteMeals.contains(meal);
    if (isExisting){
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favorite');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage('Marked as a favorite');
    }
  }

  void _selectPage(int index){
    setState(() {
      _selectPageIndex = index;
    });
  }

  void _setScreen(String identifier) async{
    Navigator.of(context).pop();
    if (identifier == 'filter'){
     final result = await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(builder: (ctx) => FilterScreen(currentFilters: selectedFilters)));
     print(result);
     setState(() {
       selectedFilters = result ?? kInitialFilters;
     });
   }
  }
  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal){
      if(selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if(selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if(selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if(selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Widget activePage = CategoriesScreen(onToggleFavorite: _toggleMealFavoriteStatus, availableMeals: availableMeals);
    var activePageTitle = 'Categories';

    if(_selectPageIndex == 1){
      activePage = MealsScreen(meals: _favoriteMeals, onToggleFavorite: _toggleMealFavoriteStatus);
      activePageTitle =  'Your Favorite';
    }

     return Scaffold(
       appBar: AppBar(
         title: Text(
           activePageTitle
         ),
       ),
       drawer: MainDrawer(onSelectScreen: _setScreen),
       body: activePage,
       bottomNavigationBar: BottomNavigationBar(onTap: _selectPage, currentIndex: _selectPageIndex,
         items: const [
           BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Categories' ),
           BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorite' )
         ],
       ),
     );
  }

}
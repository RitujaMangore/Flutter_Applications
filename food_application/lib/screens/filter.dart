import 'package:flutter/material.dart';
import 'package:food_application/main.dart';
import 'package:food_application/screens/tabs.dart';
import 'package:food_application/widgets/main_drawer.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan
}

class FilterScreen extends StatefulWidget{
  const FilterScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;
  @override
  State<StatefulWidget> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen>{
  var _glutenFreeFilterList = false;
  var _lactoseFreeFilterList = false;
  var _vegetarianFilterList = false;
  var _veganFilterList = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterList = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterList = widget.currentFilters[Filter.lactoseFree]!;
    _veganFilterList = widget.currentFilters[Filter.vegan]!;
    _vegetarianFilterList = widget.currentFilters[Filter.vegetarian]!;
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: const Text('Your Filters'),
       ),
       // drawer: MainDrawer(onSelectScreen: (String identifier) {
       //   Navigator.of(context).pop();
       //   if( identifier == 'meals'){
       //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const TabsScreens()));
       //   }
       // },),
       body: WillPopScope(
         onWillPop: () async{
           Navigator.of(context).pop({
             Filter.glutenFree : _glutenFreeFilterList,
             Filter.lactoseFree : _lactoseFreeFilterList,
             Filter.vegetarian : _vegetarianFilterList,
             Filter.vegan : _veganFilterList,
           });
           return false;
         },
         child:
         Column(
           children: [
             SwitchListTile(
               value: _glutenFreeFilterList,
               onChanged: (isChecked){
                 setState(() {
                   _glutenFreeFilterList = isChecked;
                 });
               },
               title: Text(
                   'Gluten-free',
                   style: Theme.of(context).textTheme.titleLarge!.copyWith(
                     color: Theme.of(context).colorScheme.onBackground,)
               ),
               subtitle: Text(
                   'Only include gluten-free meals.',
                   style: Theme.of(context).textTheme.labelMedium!.copyWith(
                     color: Theme.of(context).colorScheme.onBackground,)
               ) ,
               activeColor: Theme.of(context).colorScheme.tertiary,
               contentPadding: const EdgeInsets.only(left: 34, right: 22),
             ),
             SwitchListTile(
               value: _lactoseFreeFilterList,
               onChanged: (isChecked){
                 setState(() {
                   _lactoseFreeFilterList = isChecked;
                 });
               },
               title: Text(
                   'Lactose-free',
                   style: Theme.of(context).textTheme.titleLarge!.copyWith(
                     color: Theme.of(context).colorScheme.onBackground,)
               ),
               subtitle: Text(
                   'Only include lactose-free meals.',
                   style: Theme.of(context).textTheme.labelMedium!.copyWith(
                     color: Theme.of(context).colorScheme.onBackground,)
               ) ,
               activeColor: Theme.of(context).colorScheme.tertiary,
               contentPadding: const EdgeInsets.only(left: 34, right: 22),
             ),
             SwitchListTile(
               value: _vegetarianFilterList,
               onChanged: (isChecked){
                 setState(() {
                   _vegetarianFilterList = isChecked;
                 });
               },
               title: Text(
                   'Vegetarian',
                   style: Theme.of(context).textTheme.titleLarge!.copyWith(
                     color: Theme.of(context).colorScheme.onBackground,)
               ),
               subtitle: Text(
                   'Only include vegetarian meals.',
                   style: Theme.of(context).textTheme.labelMedium!.copyWith(
                     color: Theme.of(context).colorScheme.onBackground,)
               ) ,
               activeColor: Theme.of(context).colorScheme.tertiary,
               contentPadding: const EdgeInsets.only(left: 34, right: 22),
             ),
             SwitchListTile(
               value: _veganFilterList,
               onChanged: (isChecked){
                 setState(() {
                   _veganFilterList = isChecked;
                 });
               },
               title: Text(
                   'Vegan',
                   style: Theme.of(context).textTheme.titleLarge!.copyWith(
                     color: Theme.of(context).colorScheme.onBackground,)
               ),
               subtitle: Text(
                   'Only include vegan meals.',
                   style: Theme.of(context).textTheme.labelMedium!.copyWith(
                     color: Theme.of(context).colorScheme.onBackground,)
               ) ,
               activeColor: Theme.of(context).colorScheme.tertiary,
               contentPadding: const EdgeInsets.only(left: 34, right: 22),
             )
           ],
         ),
       )
     );
  }
}
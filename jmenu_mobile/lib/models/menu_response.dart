// import 'package:jmenu_mobile/menu_constants.dart';
// import 'package:jmenu_mobile/models/menu_item.dart';

// class MenuResponse {
//   var kitchens =
// }

// class Kitchen {
//   menuTypes =
// }

// class _MenuType {
//   List<_Menu> menus;

//   _MenuType(this.menus);

//   static fromJson(Map<String, dynamic> json){
//     List<_Menu> menus;

//     return _MenuType(menus);
//   }
// }

// class _Menu {
//   _Day day;

//   _Menu(this.day);

//   static fromJson(Map<String, dynamic> json){
//     return _Menu(_Day.fromJson(json['days'].first));
//   }
// }

// class _Day {
//   List<_MealOption> mealOptions;

//   _Day(this.mealOptions);

//   static fromJson(Map<String, dynamic> json){
//     return _Day(_MealOption.fromJson(json['mealoptions']));
//   }
// }

// class _MealOption {
//   List<MenuItem> menuItems;

//   _MealOption(this.menuItems);

//   static fromJson(Map<String, dynamic> json) {
//     List<MenuItem> items = [];
//     for(var item in json['menuItems']){
//       if (MenuConstants.skippedItems.contains(item['name'])){
//         items.add(MenuItem(item['name'], item['diets']));
//       }
//     }
//     return _MealOption(
//       items
//     );
//   }
// }

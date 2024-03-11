import 'package:flutter/material.dart';
import 'package:jmenu_mobile/menu_constants.dart';
import 'package:jmenu_mobile/menu_service.dart';
import 'package:jmenu_mobile/models/settings_object.dart';

class MenuListView extends StatelessWidget {
  MenuListView({
    super.key,
    required this.date,
    required this.languageCode,
    required this.settings,
  });
  final service = MenuService();
  final DateTime date;
  final String languageCode;
  final SettingsObject settings;

  @override
  Widget build(BuildContext context) {
    var futures = MenuConstants.restaurants
        .map((res) => service.getMenuItems(res, date, lang: languageCode));
    return FutureBuilder(
      future: Future.wait(futures),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data != null) {
          var filtered = settings.filteredMarkers;
          var letters = filtered.map((e) => e.letter).toSet();
          return ListView.builder(
            shrinkWrap: true,
            itemCount: MenuConstants.restaurants.length,
            itemBuilder: (context, index) {
              var res = MenuConstants.restaurants[index];
              var items = snapshot.data![index];
              List<Widget> children = [];
              for (var item in items) {
                var child = Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.name),
                    Text(
                      item.diets.join(','),
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    )
                  ],
                );
                if (letters.isNotEmpty) {
                  var diets = item.diets.join(' ');
                  if (letters.every(diets.contains)) {
                    children.add(child);
                  }
                } else {
                  children.add(child);
                }
              }
              return ExpansionTile(
                  title: Text(res.name),
                  initiallyExpanded: true,
                  childrenPadding: const EdgeInsets.all(8.0),
                  leading: const Icon(Icons.restaurant_menu),
                  children: children);
            },
          );
        } else {
          return const Text("Something went wrong...");
        }
      },
    );
  }
}

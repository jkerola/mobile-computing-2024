import 'dart:convert';

import 'package:http/http.dart';
import "package:intl/intl.dart";
import 'package:jmenu_mobile/menu_constants.dart';
import 'package:jmenu_mobile/models/menu_item.dart';
import 'package:jmenu_mobile/models/restaurant.dart';

class MenuService {
  final http = Client();
  final apiUrl = "https://fi.jamix.cloud/apps/menuservice/rest/haku/menu";
  Future<List<MenuItem>> getMenuItems(Restaurant res, DateTime fetchDate,
      {String lang = 'fi'}) async {
    var date = DateFormat("yyyyMMdd").format(fetchDate);

    var url = Uri.parse(
        "$apiUrl/${res.clientId}/${res.kitchenId}?lang=$lang&date=$date");

    var response = await http.get(url);

    return _parseMenu(json.decode(utf8.decode((response.bodyBytes))), res);
  }

  List<MenuItem> _parseMenu(List<dynamic> data, Restaurant res) {
    var menus = [];
    for (var kitchen in data) {
      for (var mType in kitchen['menuTypes']) {
        if (res.relevantMenus.isEmpty ||
            res.relevantMenus.contains(mType['menuTypeName'])) {
          menus.addAll(mType['menus']);
        }
      }
    }
    if (menus.isEmpty) {
      return [];
    }
    List<MenuItem> items = [];
    for (var menu in menus) {
      var day = menu["days"][0];
      var mealopts = day["mealoptions"];
      for (var opt in mealopts) {
        for (var item in opt['menuItems']) {
          if (!MenuConstants.skippedItems.contains(item['name'])) {
            items.add(MenuItem.fromJson(item));
          }
        }
      }
    }
    return items;
  }
}

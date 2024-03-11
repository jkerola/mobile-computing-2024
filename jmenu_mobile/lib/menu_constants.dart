import 'package:jmenu_mobile/models/restaurant.dart';

class MenuConstants {
  static final skippedItems = [
    "proteiinilisäke",
    "Täysjyväriisi",
    "Lämmin kasvislisäke",
    "Höyryperunat",
    "Tumma pasta",
    "Meillä tehty perunamuusi",
    "Mashed Potatoes",
    "Dark Pasta",
    "Whole Grain Rice",
    "Hot Vegetable  Side",
  ];

  static final restaurants = [
    Restaurant(
      "Foobar",
      93077,
      49,
      84,
      ["Foobar Salad and soup", "Foobar Rohee"],
    ),
    Restaurant(
      "Foodoo",
      93077,
      48,
      89,
      ["Foodoo Salad and soup", "Foodoo Reilu"],
    ),
    Restaurant("Kastari", 95663, 5, 2, ["Ruokalista"]),
    Restaurant("Kylymä", 93077, 48, 92, ["Kylymä Rohee"]),
    Restaurant("Mara", 93077, 49, 111, ["Salad and soup", "Ravintola Mara"]),
    Restaurant("Napa", 93077, 48, 79, ["Napa Rohee"]),
  ];
}

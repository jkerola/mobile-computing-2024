import 'package:shared_preferences/shared_preferences.dart';

class SettingsObject {
  String languageCode = "en";
  bool glutenfree = false;
  bool milkfree = false;
  bool lactosefree = false;
  bool eggfree = false;
  bool vegan = false;
  bool containsSoy = false;
  bool containsMustard = false;
  bool containsCellery = false;

  SettingsObject(
    this.languageCode,
    this.glutenfree,
    this.milkfree,
    this.lactosefree,
    this.eggfree,
    this.vegan,
    this.containsCellery,
    this.containsMustard,
    this.containsSoy,
  );

  static Future<SettingsObject> loadPreferences() async {
    var prefs = await SharedPreferences.getInstance();
    return SettingsObject(
      prefs.getString("languageCode") ?? "en",
      prefs.getBool("glutenfree") ?? false,
      prefs.getBool("milkfree") ?? false,
      prefs.getBool("lactosefree") ?? false,
      prefs.getBool("eggfree") ?? false,
      prefs.getBool("vegan") ?? false,
      prefs.getBool("containsCellery") ?? false,
      prefs.getBool("containsMustard") ?? false,
      prefs.getBool("containsSoy") ?? false,
    );
  }

  void setLanguageCode(String val) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("languageCode", val);
  }

  List<AllergenMarker> get filteredMarkers =>
      markers.where((e) => e.value == true).toList();

  List<AllergenMarker> get markers => [
        AllergenMarker(
            "glutenfree", "Gluten-free", "Gluteeniton", "G", glutenfree),
        AllergenMarker("milkfree", "Milk-free", "Maidoton", "M", milkfree),
        AllergenMarker(
            "lactosefree", "Lactose-free", "Laktoositon", "L", lactosefree),
        AllergenMarker("eggfree", "Egg-free", "Munaton", "Mu", eggfree),
        AllergenMarker("vegan", "Vegan", "Vegaaninen", "VEG", vegan),
        AllergenMarker("containsCellery", "Contains cellery",
            "Sisältää selleriä", "SE", containsCellery),
        AllergenMarker("containsMustard", "Contains mustard",
            "Sisältää sinappia", "SI", containsMustard),
        AllergenMarker("containsSoy", "Contains Soy", "Sisältää soijaa", "SO",
            containsSoy),
      ];
}

class AllergenMarker {
  String key;
  String english;
  String finnish;
  String letter;
  bool value;

  AllergenMarker(this.key, this.english, this.finnish, this.letter, this.value);

  setValue(bool value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }
}

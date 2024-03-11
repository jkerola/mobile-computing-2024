class MenuItem {
  String name;
  List<String> diets;

  MenuItem(this.name, this.diets);

  static fromJson(Map<String, dynamic> json) {
    List<String> diets = json['diets'].split(',');
    return MenuItem(json['name'], diets);
  }

  @override
  String toString() {
    return "{name: $name, diets: ${diets.join(',')}}";
  }
}

class Restaurant {
  String name;
  int clientId;
  int kitchenId;
  int menuType;
  List<String> relevantMenus;

  Restaurant(
    this.name,
    this.clientId,
    this.kitchenId,
    this.menuType,
    this.relevantMenus,
  );
}

class ApiEndpoints {
  static const String baseUrl = "https://www.themealdb.com/api/json/v1/1/";

  // Areas
  static const String listAreas = "list.php?a=list";

  // Categories
  static const String listCategories = "categories.php";

  // Meals
  static const String filterByArea = "filter.php";
  static const String filterByCategory = "filter.php";

  // Meal Details
  static const String lookupById = "lookup.php";
}

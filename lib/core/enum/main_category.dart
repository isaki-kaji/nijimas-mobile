enum MainCategory {
  food("食事"),
  hobby("趣味"),
  fashion("ファッション"),
  goods("雑貨"),
  daily("日用品"),
  trip("旅行"),
  entertainment("交際費"),
  traffic("交通費"),
  other("その他");

  const MainCategory(this.name);
  final String name;
}

List<String> mainCategoryNames() {
  return MainCategory.values.map((e) => e.name).toList();
}

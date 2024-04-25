enum MainCategoryName {
  food("食費"),
  hobby("趣味"),
  daily("日用品"),
  traffic("交通費"),
  clothes("衣服"),
  entertainment("交際費"),
  other("その他");

  const MainCategoryName(this.name);
  final String name;
}

List<String> mainCategoryNames() {
  return MainCategoryName.values.map((e) => e.name).toList();
}

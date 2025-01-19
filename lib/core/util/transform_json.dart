String snakeToCamel(String input) {
  return input.replaceAllMapped(RegExp(r'_([a-z])'), (Match match) {
    return match.group(1)!.toUpperCase();
  });
}

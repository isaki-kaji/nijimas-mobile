class YearMonth {
  final int year;
  final int month;

  YearMonth({
    required this.year,
    required this.month,
  });

  static YearMonth now() {
    final now = DateTime.now();
    return YearMonth(year: now.year, month: now.month);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is YearMonth && other.year == year && other.month == month;
  }

  @override
  int get hashCode => year.hashCode ^ month.hashCode;

  YearMonth addMonth() {
    if (isCurrent()) {
      return this;
    }
    if (month == 12) {
      return YearMonth(year: year + 1, month: 1);
    } else {
      return YearMonth(year: year, month: month + 1);
    }
  }

  YearMonth subtractMonth() {
    if (!canSubtract()) {
      return this;
    }
    if (month == 1) {
      return YearMonth(year: year - 1, month: 12);
    } else {
      return YearMonth(year: year, month: month - 1);
    }
  }

  bool isCurrent() {
    return this == YearMonth.now();
  }

  bool canSubtract() {
    return this != YearMonth(year: 2024, month: 1);
  }
}

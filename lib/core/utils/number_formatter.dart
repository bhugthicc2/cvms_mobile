class NumberFormatter {
  static String compact(num value) {
    if (value >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(1)}B';
    } else if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    } else {
      return value.toStringAsFixed(0);
    }
  }

  static String percent(num part, num total) {
    if (total == 0) return '0%';
    return '${((part / total) * 100).toStringAsFixed(0)}%';
  }
}

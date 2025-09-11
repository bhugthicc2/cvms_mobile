class StatisticsModel {
  final int entered;
  final int exited;
  final int others;
  final int total;

  const StatisticsModel({
    required this.entered,
    required this.exited,
    required this.others,
    required this.total,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      entered: json['entered'] ?? 0,
      exited: json['exited'] ?? 0,
      others: json['others'] ?? 0,
      total: json['total'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entered': entered,
      'exited': exited,
      'others': others,
      'total': total,
    };
  }

  double get enteredPercentage => total > 0 ? (entered / total) * 100 : 0;
  double get exitedPercentage => total > 0 ? (exited / total) * 100 : 0;
  double get othersPercentage => total > 0 ? (others / total) * 100 : 0;
}

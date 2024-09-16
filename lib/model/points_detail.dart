class PointsDetail {
  final int change;
  final String date;

  PointsDetail({required this.change, required this.date});

  factory PointsDetail.fromJson(Map<String, dynamic> json) {
    return PointsDetail(
      change: json['change'],
      date: json['date'],
    );
  }
}

class UserPointsWithDetails {
  final String id;
  final String username;
  final int totalPoints;
  final List<PointsDetail> details;

  UserPointsWithDetails({
    required this.id,
    required this.username,
    required this.totalPoints,
    required this.details,
  });

  factory UserPointsWithDetails.fromJson(Map<String, dynamic> json) {
    var detailsList = (json['details'] as List)
        .map((detail) => PointsDetail.fromJson(detail))
        .toList();

    return UserPointsWithDetails(
      id: json['_id'],
      username: json['username'],
      totalPoints: json['total_points'],
      details: detailsList,
    );
  }
}

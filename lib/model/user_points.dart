class UserPoints {
  final String username;
  final int totalPoints;

  UserPoints({required this.username, required this.totalPoints});

  factory UserPoints.fromJson(Map<String, dynamic> json) {
    return UserPoints(
      username: json['username'],
      totalPoints: json['total_points'],
    );
  }
}

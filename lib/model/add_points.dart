class AddPointsRequest {
  final String username;
  final String pid;

  AddPointsRequest({required this.username, required this.pid});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'pid': pid,
    };
  }
}

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../core/env/env.dart';
import '../model/add_points.dart';
import '../model/points_detail.dart';
import '../model/user_points.dart';

class PointsAndRankedController extends GetxController {
  final Dio dio = Dio();
  final String baseUrl = Env.pointsBaseUrl;

  // Get all points
  Future<List<UserPoints>> getPoints() async {
    try {
      var response = await dio.get('$baseUrl/points');
      return (response.data as List).map((item) => UserPoints.fromJson(item)).toList();
    } catch (e) {
      print("Error fetching points: $e");
      return [];
    }
  }

  // Add points for a user
  Future<String> addPoints(String username, String pid) async {
    try {
      AddPointsRequest request = AddPointsRequest(username: username, pid: pid);
      var response = await dio.put(
        '$baseUrl/points',
        data: request.toJson(),
      );
      return response.data['message'];
    } catch (e) {
      print("Error adding points: $e");
      return "Failed to add points";
    }
  }

  // Get points by username
  Future<UserPointsWithDetails?> getPointsByUsername(String username) async {
    try {
      var response = await dio.get('$baseUrl/points/$username');
      return UserPointsWithDetails.fromJson(response.data);
    } catch (e) {
      print("Error fetching points for user $username: $e");
      return null;
    }
  }
}

import 'dart:convert';

import 'package:bellevie/app/services/api_service.dart';
import 'package:bellevie/app/services/auth_service.dart';
import 'package:http/http.dart' as http;

class VideoRoomService {
  final AppApiService _apiService = AppApiService();

  Future<int> getMyRoomId() async {
    final accessToken = AuthService.to.accessToken.value;

    final response = await http.get(
      _apiService.buildUrl('/api/v1/video-rooms/rooms/my-rooms/'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (data is List && data.isNotEmpty) {
        return data.first['id'];
      }

      throw Exception('No video room found');
    }

    throw Exception(
      data['detail']?.toString() ?? 'Failed to load video rooms',
    );
  }

  Future<Map<String, dynamic>> getAgoraToken(int roomId) async {
    final accessToken = AuthService.to.accessToken.value;

    final response = await http.get(
      _apiService.buildUrl('/api/v1/video-rooms/rooms/$roomId/token/'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    }

    throw Exception(
      data['detail']?.toString() ?? 'Failed to get video call token',
    );
  }
}
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AppApiService {
   //static const String baseUrl = 'http://192.168.0.246:5000';
  static const String baseUrl =
      'https://dara-unadjudicated-befittingly.ngrok-free.dev';

  Uri buildUrl(String path) {
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return Uri.parse('$baseUrl$normalizedPath');
  }

  Future<http.Response> post({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final uri = buildUrl(path);
    final requestHeaders = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...?headers,
    };

    debugPrint('POST => $uri');
    debugPrint('POST body => ${jsonEncode(body ?? <String, dynamic>{})}');

    final response = await http
        .post(
          uri,
          headers: requestHeaders,
          body: jsonEncode(body ?? <String, dynamic>{}),
        )
        .timeout(const Duration(seconds: 30));

    debugPrint('POST status <= ${response.statusCode}');
    debugPrint('POST response <= ${response.body}');

    return response;
  }

  Future<http.Response> get({
    required String path,
    Map<String, String>? headers,
  }) async {
    final uri = buildUrl(path);
    final requestHeaders = <String, String>{
      'Accept': 'application/json',
      ...?headers,
    };

    debugPrint('GET => $uri');
    debugPrint('GET headers => $requestHeaders');

    final response = await http
        .get(
          uri,
          headers: requestHeaders,
        )
        .timeout(const Duration(seconds: 30));

    debugPrint('GET status <= ${response.statusCode}');
    debugPrint('GET response <= ${response.body}');

    return response;
  }

  Future<http.Response> putMultipart({
    required String path,
    required String fileField,
    required String filePath,
    Map<String, String>? headers,
  }) async {
    final uri = buildUrl(path);
    final request = http.MultipartRequest('PUT', uri);

    request.headers.addAll({
      'Accept': 'application/json',
      ...?headers,
    });

    request.files.add(await http.MultipartFile.fromPath(fileField, filePath));

    debugPrint('PUT multipart => $uri');
    debugPrint('PUT multipart headers => ${request.headers}');
    debugPrint('PUT multipart file => $fileField: $filePath');

    final streamedResponse =
        await request.send().timeout(const Duration(seconds: 30));
    final response = await http.Response.fromStream(streamedResponse);

    debugPrint('PUT multipart status <= ${response.statusCode}');
    debugPrint('PUT multipart response <= ${response.body}');

    return response;
  }
}

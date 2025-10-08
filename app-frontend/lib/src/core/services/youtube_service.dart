// lib/src/core/services/youtube_service.dart
import 'dart:convert';
import 'dart:io'; // To catch SocketException
import 'package:al_faruk_app/src/core/models/video_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class YouTubeService {
  // 1. CORRECTLY get the key from the .env file using its NAME.
  final String? _apiKey = dotenv.env['YOUTUBE_API_KEY'];

  // 2. A more robust way to get the best available thumbnail URL.
  String _getBestThumbnailUrl(Map<String, dynamic> thumbnails) {
    if (thumbnails.containsKey('high')) {
      return thumbnails['high']['url'];
    } else if (thumbnails.containsKey('medium')) {
      return thumbnails['medium']['url'];
    } else if (thumbnails.containsKey('default')) {
      return thumbnails['default']['url'];
    }
    // Return a placeholder if no thumbnail is found
    return 'https://via.placeholder.com/480x360.png?text=No+Image';
  }

  Future<List<Video>> fetchPlaylistVideos({required String playlistId}) async {
    if (_apiKey == null || _apiKey!.isEmpty) {
      throw Exception('API Key not found or is empty. Make sure you have set it up correctly in your .env file');
    }

    final url = Uri.parse(
        'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=$playlistId&maxResults=20&key=$_apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> items = data['items'];

        return items.map((item) {
          final snippet = item['snippet'];
          if (snippet == null || snippet['resourceId'] == null) {
            return null; // Skip invalid items
          }

          final thumbnailUrl = _getBestThumbnailUrl(snippet['thumbnails']);

          return Video(
            id: snippet['resourceId']['videoId'],
            title: snippet['title'],
            thumbnailUrl: thumbnailUrl,
            channelName: snippet['videoOwnerChannelTitle'],
            uploadDate: '',
            viewCount: '',
            description: snippet['description'],
          );
        }).whereType<Video>().toList(); // Filter out any null items
      } else {
        // Provide more detailed error information
        final errorData = json.decode(response.body);
        final errorMessage = errorData['error']['message'] ?? 'Unknown API error';
        throw Exception('Failed to load playlist: $errorMessage');
      }
    } on SocketException {
      // 3. Handle cases where there is no internet connection.
      throw Exception('No Internet connection. Please check your network.');
    } catch (e) {
      // Catch any other unexpected errors.
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
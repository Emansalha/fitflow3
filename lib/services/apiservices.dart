import 'dart:convert';
import 'package:http/http.dart' as http;

import '../setting/apisetting.dart';

class ApiService {
  static Future<List<dynamic>> getExercises() async {
    final url = Uri.parse(ApiSetting.exercisesUrl); // استخدام الرابط من ApiSetting

    try {
      final response = await http.get(
        url,
        headers: ApiSetting.headers, // استخدام الـ Headers من ApiSetting
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('فشل جلب البيانات: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }

  /// جلب فيديوهات التمارين الرياضية من YouTube Data API (https://www.googleapis.com/youtube/v3/search)
  static Future<List<dynamic>> fetchYouTubeVideos(String query, {String apiKey = 'YOUR_YOUTUBE_API_KEY'}) async {
    final url = Uri.parse(ApiSetting.youtubeSearchUrl(query, apiKey: apiKey));

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['items'] ?? [];
      } else {
        throw Exception('فشل جلب فيديوهات يوتيوب: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال بـ YouTube API: $e');
    }
  }

  /// جلب صور التمارين والجيم من Pixabay API (https://pixabay.com/api/)
  static Future<List<dynamic>> fetchPixabayImages(String query, {String apiKey = 'YOUR_PIXABAY_API_KEY'}) async {
    final url = Uri.parse(ApiSetting.pixabaySearchImagesUrl(query, apiKey: apiKey));

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['hits'] ?? [];
      } else {
        throw Exception('فشل جلب صور Pixabay: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال بـ Pixabay API: $e');
    }
  }

  /// جلب فيديوهات التمارين الرياضية من Pixabay API (https://pixabay.com/api/videos/)
  static Future<List<dynamic>> fetchPixabayVideos(String query, {String apiKey = 'YOUR_PIXABAY_API_KEY'}) async {
    final url = Uri.parse(ApiSetting.pixabaySearchVideosUrl(query, apiKey: apiKey));

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['hits'] ?? [];
      } else {
        throw Exception('فشل جلب فيديوهات Pixabay: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال بـ Pixabay API (Videos): $e');
    }
  }

  /// جلب روابط فيديوهات MP4 المباشرة للتمارين الرياضية من Pixabay Video API (https://pixabay.com/api/videos/)
  static Future<List<String>> fetchPixabayDirectVideoUrls(String query, {String apiKey = 'YOUR_PIXABAY_API_KEY'}) async {
    try {
      final hits = await fetchPixabayVideos(query, apiKey: apiKey);
      final List<String> videoUrls = [];

      for (final hit in hits) {
        if (hit is Map && hit.containsKey('videos')) {
          final videosMap = hit['videos'] as Map<String, dynamic>?;
          if (videosMap != null) {
            final videoData = videosMap['medium'] ?? videosMap['large'] ?? videosMap['tiny'] ?? videosMap['small'];
            if (videoData != null && videoData['url'] != null) {
              videoUrls.add(videoData['url'] as String);
            }
          }
        }
      }
      return videoUrls;
    } catch (_) {
      return [];
    }
  }
}
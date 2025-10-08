// lib/src/core/models/video_model.dart
class Video {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelName;
  final String viewCount;
  final String uploadDate;
  final String description;

  // THE FIX IS HERE: We've added the 'const' keyword to the constructor.
  const Video({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.channelName,
    required this.viewCount,
    required this.uploadDate,
    required this.description,
  });
}
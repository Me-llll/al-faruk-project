// lib/src/core/models/content_item_model.dart

// A generic model to represent any piece of content with a thumbnail.
class ContentItem {
  final String id;
  final String title;
  final String thumbnailUrl;

  const ContentItem({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
  });
}
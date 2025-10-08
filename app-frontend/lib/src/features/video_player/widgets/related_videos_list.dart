// lib/src/features/video_player/widgets/related_videos_list.dart
import 'package:al_faruk_app/src/core/models/video_model.dart';
import 'package:flutter/material.dart';

class RelatedVideosList extends StatelessWidget {
  final List<Video> relatedVideos;
  // --- 1. ADD THE CALLBACK FUNCTION PARAMETER ---
  final Function(Video) onVideoTap;

  const RelatedVideosList({
    super.key,
    required this.relatedVideos,
    required this.onVideoTap, // <-- Make it required in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text('Up Next', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: relatedVideos.length,
          itemBuilder: (context, index) {
            final video = relatedVideos[index];
            return ListTile(
              leading: SizedBox(
                width: 120,
                child: Image.network(
                  video.thumbnailUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported, color: Colors.grey);
                  },
                ),
              ),
              title: Text(video.title, maxLines: 2, overflow: TextOverflow.ellipsis),
              subtitle: Text(video.channelName),
              // --- 2. CALL THE FUNCTION ON TAP ---
              onTap: () {
                onVideoTap(video); // Pass the tapped video back to the parent
              },
            );
          },
        ),
      ],
    );
  }
}
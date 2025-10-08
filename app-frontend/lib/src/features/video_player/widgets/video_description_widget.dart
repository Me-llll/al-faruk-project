// lib/src/features/video_player/widgets/video_description_widget.dart
import 'package:al_faruk_app/src/core/models/video_model.dart';
import 'package:flutter/material.dart';

class VideoDescriptionWidget extends StatefulWidget {
  final Video video;
  const VideoDescriptionWidget({super.key, required this.video});
  @override
  State<VideoDescriptionWidget> createState() => _VideoDescriptionWidgetState();
}

class _VideoDescriptionWidgetState extends State<VideoDescriptionWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.video.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('${widget.video.viewCount} views • ${widget.video.uploadDate}', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600])),
          const SizedBox(height: 16),
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(widget.video.description, maxLines: _isExpanded ? 100 : 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium),
              Text(_isExpanded ? 'Show less' : 'Show more', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey)),
            ]),
          ),
          const Divider(height: 32),
        ],
      ),
    );
  }
}
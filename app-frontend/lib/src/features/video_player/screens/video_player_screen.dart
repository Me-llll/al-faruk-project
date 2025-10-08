// lib/src/features/video_player/screens/video_player_screen.dart
import 'package:al_faruk_app/src/core/models/video_model.dart';
import 'package:al_faruk_app/src/features/video_player/widgets/related_videos_list.dart';
import 'package:al_faruk_app/src/features/video_player/widgets/video_description_widget.dart';
import 'package:flutter/material.dart';
// --- 1. IMPORT THE NEW PACKAGE ---
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayerScreen extends StatefulWidget {
  final Video video;
  final List<Video> playlist;
  const VideoPlayerScreen({super.key, required this.video, required this.playlist});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  // --- 2. REPLACE THE CONTROLLER ---
  late YoutubePlayerController _controller;
  
  late Video _currentVideo;

  // final List<Video> _relatedVideos = const [
  //   Video(id: 'b-y6t8p-54c', title: 'The Golden Age of Baghdad', thumbnailUrl: 'https://img.youtube.com/vi/b-y6t8p-54c/hqdefault.jpg', channelName: 'History Hub', viewCount: '890k', uploadDate: '1 month ago', description: ''),
  //   Video(id: 'grZQ_D-IftU', title: 'Calligraphy for Beginners', thumbnailUrl: 'https://img.youtube.com/vi/grZQ_D-IftU/hqdefault.jpg', channelName: 'Artisan Corner', viewCount: '312k', uploadDate: '3 weeks ago', description: ''),
  // ];

  @override
  void initState() {
    super.initState();
    _currentVideo = widget.video;
    
    // --- 3. INITIALIZE THE NEW CONTROLLER ---
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        mute: false,
      ),
    );
    
    // Load the initial video
    _controller.loadVideoById(videoId: _currentVideo.id);
  }

  void _playNextVideo(Video nextVideo) {
    setState(() {
      _currentVideo = nextVideo;
    });
    // Use the new method to load a video
    _controller.loadVideoById(videoId: nextVideo.id);
  }

  @override
  void dispose() {
    _controller.close(); // The new dispose method is called 'close'
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final upNextVideos = widget.playlist.where((v) => v.id != _currentVideo.id).toList();
    // --- 4. REPLACE YoutubePlayerBuilder and YoutubePlayer ---
    // The new package provides a single, simpler widget.
    return Scaffold(
      appBar: AppBar(title: const Text('Now Playing')),
      body: ListView(
        children: [
          // The main YoutubePlayer widget
          YoutubePlayer(
            controller: _controller,
            aspectRatio: 16 / 9,
          ),
          
          // The rest of your UI remains exactly the same
          VideoDescriptionWidget(video: _currentVideo),
          
          RelatedVideosList(
            relatedVideos: upNextVideos, 
            onVideoTap: _playNextVideo,
          ),
        ],
      ),
    );
  }
}
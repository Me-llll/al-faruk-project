// lib/src/features/main_scaffold/pages/videos_page.dart
import 'package:al_faruk_app/src/core/models/video_model.dart';
import 'package:al_faruk_app/src/core/services/youtube_service.dart';
import 'package:al_faruk_app/src/features/video_player/screens/video_player_screen.dart';
import 'package:flutter/material.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({super.key});

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  // --- 1. NEW STATE VARIABLES FOR SEARCH ---
  bool _isLoading = true;
  String? _errorMessage;
  
  // This holds the original, full list of videos from the API
  List<Video> _allVideos = [];
  // This holds the list of videos to be displayed (after filtering)
  List<Video> _filteredVideos = [];

  // Controller for the search text field
  final TextEditingController _searchController = TextEditingController();

  final YouTubeService _youTubeService = YouTubeService();
  final String _playlistId = 'UUDIi_4EqI8j8e8rAyIIoPsQ';

  @override
  void initState() {
    super.initState();
    _fetchVideos(); // Fetch data when the page loads
    
    // Add a listener to the search controller to filter as the user types
    _searchController.addListener(_filterVideos);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterVideos);
    _searchController.dispose();
    super.dispose();
  }

  // --- 2. NEW METHOD TO FETCH AND SET DATA ---
  Future<void> _fetchVideos() async {
    try {
      final videos = await _youTubeService.fetchPlaylistVideos(playlistId: _playlistId);
      setState(() {
        _allVideos = videos;
        _filteredVideos = videos; // Initially, the filtered list is the full list
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  // --- 3. NEW METHOD TO FILTER VIDEOS ---
  void _filterVideos() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredVideos = _allVideos.where((video) {
        return video.title.toLowerCase().contains(query);
      }).toList();
    });
  }

  // --- 4. BUILD THE NEW UI ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // --- The Search Bar ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search videos...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
              ),
            ),
          ),
          // --- The Content Area ---
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  // --- 5. HELPER WIDGET TO BUILD CONTENT BASED ON STATE ---
  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Error: $_errorMessage'),
        ),
      );
    }

    if (_filteredVideos.isEmpty) {
      return const Center(child: Text('No videos found.'));
    }

    // Build the list using the filtered data
    return ListView.builder(
      itemCount: _filteredVideos.length,
      itemBuilder: (context, index) {
        final video = _filteredVideos[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VideoPlayerScreen(
                video: video,
                playlist: _allVideos, // Pass the original full list
              ),
            ));
          },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  video.thumbnailUrl,
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: const Center(child: Icon(Icons.error_outline, color: Colors.red)),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        video.channelName,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
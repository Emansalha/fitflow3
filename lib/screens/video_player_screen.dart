import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../core/theme.dart';

/// Plays a web video (https://...) or a bundled one (assets/videos/...).
class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key, required this.source});
  final String source;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late final VideoPlayerController _c;
  late final Future<void> _init;

  @override
  void initState() {
    super.initState();
    _c = widget.source.startsWith('http')
        ? VideoPlayerController.networkUrl(Uri.parse(widget.source))
        : VideoPlayerController.asset(widget.source);
    _init = _c.initialize().then((_) {
      _c.setLooping(true);
      _c.play();
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: FutureBuilder<void>(
          future: _init,
          builder: (context, snap) {
            if (snap.hasError) {
              return const Text('Could not load this video',
                  style: TextStyle(color: Colors.white));
            }
            if (snap.connectionState != ConnectionState.done) {
              return const CircularProgressIndicator(color: AppColors.mint);
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AspectRatio(
                  aspectRatio: _c.value.aspectRatio,
                  child: VideoPlayer(_c),
                ),
                const SizedBox(height: 12),
                VideoProgressIndicator(
                  _c,
                  allowScrubbing: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  colors: const VideoProgressColors(playedColor: AppColors.mint),
                ),
                ValueListenableBuilder<VideoPlayerValue>(
                  valueListenable: _c,
                  builder: (_, v, __) => IconButton(
                    iconSize: 52,
                    color: Colors.white,
                    tooltip: v.isPlaying ? 'Pause' : 'Play',
                    icon: Icon(v.isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_filled),
                    onPressed: () => v.isPlaying ? _c.pause() : _c.play(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

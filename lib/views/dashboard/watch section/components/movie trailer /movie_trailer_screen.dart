import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailerScreen extends StatefulWidget {
  final String? videoKey;

  const MovieTrailerScreen({super.key, required this.videoKey});

  @override
  // ignore: library_private_types_in_public_api
  _MovieTrailerScreenState createState() => _MovieTrailerScreenState();
}

class _MovieTrailerScreenState extends State<MovieTrailerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoKey ?? "",
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        hideControls: true, // Hide controls for a cleaner look
        forceHD: true,
      ),
    );

    // Listen for video end event to close automatically
    _controller.addListener(() {
      if (_controller.value.isFullScreen) {
        // _controller.();
      }
      if (_controller.value.playerState == PlayerState.ended) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    // Reset orientation to portrait mode when closing the trailer screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          YoutubePlayer(
            controller: _controller,
            onEnded: (_) {
              Navigator.pop(context);
            },
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoCustomer extends StatefulWidget {
  final String videoId;
  const VideoCustomer({super.key, required this.videoId});

  @override
  VideoCustomerState createState() => VideoCustomerState();
}

class VideoCustomerState extends State<VideoCustomer> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void deactivate() {
    controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        key: UniqueKey(),
        controller: controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        onReady: () {
          print('Reproductor listo.');
        },
      ),
      builder: (context, player) {
        return Column(
          children: [
            const Text(
              "Video",
              style: TextStyle(fontSize: 18),
            ),
            player,
          ],
        );
      },
    );
  }
}

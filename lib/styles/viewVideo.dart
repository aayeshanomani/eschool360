import 'package:chewie/chewie.dart';
import 'package:eschool360/styles/common.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ViewVideo extends StatefulWidget {
  @override
  _ViewVideoState createState() => _ViewVideoState();
}

class _ViewVideoState extends State<ViewVideo> {
  ChewieController _chewieController;
  VideoPlayerController _videoPlayerController1;

  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(
        videoUrl);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: _videoPlayerController1.value.aspectRatio,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:

      // showControls: false,
       materialProgressColors: ChewieProgressColors(
         playedColor: bluecolor,
         handleColor: whitecolor,
      //   backgroundColor: Colors.grey,
        bufferedColor: bluecolor,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
       ),
      // autoInitialize: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video'),
        backgroundColor: bluecolor,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Chewie(
                  controller: _chewieController,
                ),
            ),
          ),
              
            ],
          ),
                
      );
  }
}

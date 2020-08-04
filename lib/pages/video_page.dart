import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:covid_19_flutter/theme.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.asset('assets/video/Lindungi_Diri.mp4');
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '#DiRumahAja\n#TetapSehat',
          textAlign: TextAlign.justify,
        ),
        backgroundColor: mainColor,
      ),
      body: Container(
        color: backgroundColor,
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            Text(
              'Lindugi Diri & Sesama\ndari COVID-19',
              style: titleTextFont,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5,
            ),
            Divider(),
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Center(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Sumber : Kementerian Kesehatan Republik Indonesia',
              style: subtitleTextFont.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w300,
              ),
            ),
            Divider(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(
            () {
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {
                _controller.play();
              }
            },
          );
        },
        child: Icon(
          _controller.value.isPlaying ? MdiIcons.pause : MdiIcons.play,
        ),
        backgroundColor: mainColor,
      ),
    );
  }
}

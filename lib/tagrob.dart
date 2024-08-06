import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerScreen extends StatefulWidget {
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Audio Player"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await audioPlayer.play(UrlSource(
                    'https://server16.mp3quran.net/nufais/Rewayat-Hafs-A-n-Assem/001.mp3'));
              },
              child: Text("Play"),
            ),
            ElevatedButton(
              onPressed: () async {
                await audioPlayer.pause();
              },
              child: Text("Pause"),
            ),
            ElevatedButton(
              onPressed: () async {
                await audioPlayer.resume();
              },
              child: Text("Resume"),
            ),
            ElevatedButton(
              onPressed: () async {
                await audioPlayer.stop();
              },
              child: Text("Stop"),
            ),
          ],
        ),
      ),
    );
  }
}
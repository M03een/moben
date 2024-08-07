import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';



class AudioPlayerScreen extends StatefulWidget {
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration _duration = Duration();
  Duration _position = Duration();
  String _localFilePath = '';

  @override
  void initState() {
    super.initState();
    audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        _duration = d;
      });
    }
    );

    audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        _position = p;
      });
    });
  }

  Future<void> _downloadFile(String url, String fileName) async {
    try {
      Directory? downloadsDir = await getDownloadsDirectory();
      if (downloadsDir != null) {
        String savePath = join(downloadsDir.path, fileName);
        await Dio().download(url, savePath);
        setState(() {
          _localFilePath = savePath;
        });
        print('=========================================File downloaded successfully to $savePath');
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('File downloaded successfully to $savePath')));
      } else {
        //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Unable to access downloads directory')));
        print('=========================================Unable to access downloads directory');

      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error downloading file: $e')));
      print('=========================================erorr downloadin flire');

    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

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
                String url = 'https://server16.mp3quran.net/nufais/Rewayat-Hafs-A-n-Assem/001.mp3';
                await audioPlayer.play(UrlSource(url));
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
            ElevatedButton(
              onPressed: () async {
                String url = 'https://server16.mp3quran.net/nufais/Rewayat-Hafs-A-n-Assem/001.mp3';
                await _downloadFile(url, 'audio.mp3');
              },
              child: Text("Download"),
            ),
            Slider(
              value: _position.inSeconds.toDouble(),
              min: 0.0,
              max: _duration.inSeconds.toDouble(),
              onChanged: (double value) {
                setState(() {
                  audioPlayer.seek(Duration(seconds: value.toInt()));
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(_formatDuration(_position)),
                Text(_formatDuration(_duration)),
              ],
            ),
            Text('Saved at: $_localFilePath'),
          ],
        ),
      ),
    );
  }
}

Future<Directory?> getDownloadsDirectory() async {
  if (Platform.isAndroid) {
    // Use the method to get the downloads directory on Android
    return await getExternalStorageDirectory();
  } else if (Platform.isIOS) {
    // iOS does not have a Downloads directory, so we use the documents directory
    return await getApplicationDocumentsDirectory();
  } else {
    // For other platforms, we fall back to the documents directory
    return await getApplicationDocumentsDirectory();
  }
}

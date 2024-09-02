import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import '../../../controller/downloaded_surah_audio_controller.dart';

class DownloadedSurahsPlayerView extends StatelessWidget {
  final DownloadedSurahsAudioController audioController =
  Get.put(DownloadedSurahsAudioController());

   DownloadedSurahsPlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surah Player'),
      ),
      body: Column(
        children: [
          Obx(() {
            return Text(
              audioController.currentSurahName.value.isEmpty
                  ? 'No Surah Selected'
                  : audioController.currentSurahName.value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          }),
          Obx(() {
            return Slider(
              min: 0,
              max: audioController.totalDuration.value.inSeconds.toDouble(),
              value: audioController.currentPosition.value.inSeconds.toDouble(),
              onChanged: (value) {
                audioController.seekTo(Duration(seconds: value.toInt()));
              },
            );
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous),
                onPressed: () {
                  audioController.playSurah(audioController.downloadedSurahs[
                  (audioController.downloadedSurahs.indexOf(File(
                      audioController.currentSurahName.value)) -
                      1) %
                      audioController.downloadedSurahs.length]);
                },
              ),
              Obx(() {
                return IconButton(
                  icon: Icon(audioController.isPlaying.value
                      ? Icons.pause
                      : Icons.play_arrow),
                  onPressed: () {
                    audioController.togglePlayPause();
                  },
                );
              }),
              IconButton(
                icon: const Icon(Icons.skip_next),
                onPressed: () {
                  audioController.playSurah(audioController.downloadedSurahs[
                  (audioController.downloadedSurahs.indexOf(File(
                      audioController.currentSurahName.value)) +
                      1) %
                      audioController.downloadedSurahs.length]);
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: audioController.downloadedSurahs.length,
                itemBuilder: (context, index) {
                  final surahFile = audioController.downloadedSurahs[index];
                  return ListTile(
                    title: Text(surahFile.path.split('/').last.split('.').first),
                    onTap: () {
                      audioController.playSurah(surahFile);
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

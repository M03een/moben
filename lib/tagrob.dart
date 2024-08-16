//============== play list audio service =====================

import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  // Generate a playlist with tracks from 1 to 114
  final ConcatenatingAudioSource _playlist = ConcatenatingAudioSource(
    useLazyPreparation: true,
    shuffleOrder: DefaultShuffleOrder(),
    children: List.generate(
      114,
          (index) {
        print(index);
        return AudioSource.uri(

          Uri.parse('https://server6.mp3quran.net/akdr/${(index + 1).toString().padLeft(3, '0')}.mp3'),
          tag: MediaItem(
            // Specify a unique ID for each media item:
            id: '1',
            // Metadata to display in the notification:
            album: "Album name",
            title: "Song name",
            artUri: Uri.parse('https://example.com/albumart.jpg'),
          ),
        );
      },
    ),
  );

  AudioService() {
    // Set the playlist as the audio source for the player
    _player.setAudioSource(_playlist);
  }

  // Method to play the audio
  Future<void> play() async {
    try {
      if (_player.playing) {
        _player.play();
      } else {
        // Start playing from the beginning of the playlist
        await _player.play();
      }
    } catch (e) {
      // Handle error
      print("Error playing audio: $e");
    }
  }

  // Method to play a specific track from the playlist
  Future<void> playTrack(int index) async {
    try {
      // Set the current index and play
      await _player.seek(Duration.zero, index: index);
      _player.play();
    } catch (e) {
      // Handle error
      print("Error playing specific track: $e");
    }
  }

  // Method to pause audio
  void pause() {
    _player.pause();
  }

  // Method to stop audio
  void stop() {
    _player.stop();
  }

  // Method to skip to the next track
  void next() {
    _player.seekToNext();
  }

  // Method to skip to the previous track
  void previous() {
    _player.seekToPrevious();
  }

  // Dispose the player when it's no longer needed
  void dispose() {
    _player.dispose();
  }
}

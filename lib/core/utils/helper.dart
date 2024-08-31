class HelperFunctions {
  String converterId(int id) {
    int idLength = id.toString().length;
    if (idLength > 2) {
      return id.toString();
    } else {
      if (idLength == 2) {
        return '0$id';
      } else {
        return '00$id';
      }
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    if (duration.inHours > 0) {
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    } else {
      String twoDigitMinutes = twoDigits(duration.inMinutes);
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "$twoDigitMinutes:$twoDigitSeconds";
    }
  }

  String readerUrl({required int id}) {
    switch (id) {
      case 0:
        {
          return 'https://server11.mp3quran.net/yasser/';
        }
      case 1:
        {
          return 'https://server10.mp3quran.net/minsh/minh-old-with-echo/';
        }
      case 2:
        {
          return 'https://server7.mp3quran.net/basit/';
        }
      case 3:
        {
          return 'https://server12.mp3quran.net/tblawi/';
        }
      default: {
        return'https://server11.mp3quran.net/yasser/';
      }
    }
  }
}

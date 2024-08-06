class SurahAudioIdGeneration{

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

}
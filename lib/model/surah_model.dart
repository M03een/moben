class Surah {
  int? id;
  String? name;
  int? startPage;
  int? endPage;
  int? makkia;
  int? type;

  Surah(
      {this.id,
        this.name,
        this.startPage,
        this.endPage,
        this.makkia,
        this.type});

  Surah.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startPage = json['start_page'];
    endPage = json['end_page'];
    makkia = json['makkia'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['start_page'] = startPage;
    data['end_page'] = endPage;
    data['makkia'] = makkia;
    data['type'] = type;
    return data;
  }
}
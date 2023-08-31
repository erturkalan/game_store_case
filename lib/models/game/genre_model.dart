class GenreModel {
  String? name;

  GenreModel({this.name});

  GenreModel.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}

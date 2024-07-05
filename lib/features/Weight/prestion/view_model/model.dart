class KhordaModel {
  String? name;
  String? Image;
  int? point;

  KhordaModel({required this.name, required this.point, required this.Image});

  factory KhordaModel.fromJson(jsonData) {
    return KhordaModel(
        name: jsonData['name'],
        point: jsonData['point'],
        Image: jsonData['image']);
  }
}

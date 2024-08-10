class ProfileModel {
  String? name;
  String? number;
  String? location;
  int? point;

  ProfileModel(
      {required this.location,
      this.name,
      required this.number,
      required this.point});

  factory ProfileModel.fromJson(jsonData) {
    return ProfileModel(
        name: jsonData['name'],
        number: jsonData['phoneNumber'],
        location: jsonData['location'],
        point: jsonData['points']);
  }
}

class Clinic {
  final int id;
  final String app_name;
  String? clinic_image;
  final String logo;

  Clinic({
    required this.id,
    required this.app_name,
    this.clinic_image,
    required this.logo,
  });

  factory Clinic.fromJSON(Map<String, dynamic> json) {
    return Clinic(
      id: json["id"],
      app_name: json["app_name"],
      clinic_image: json["clinic_image"],
      logo: json["logo"],
    );
  }

  @override
  String toString() {
    return '''
id: $id,
app_name: $app_name,
clinic_image: $clinic_image
logo: $logo
''';
  }
}

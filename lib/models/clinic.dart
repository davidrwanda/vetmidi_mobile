class Clinic {
  final int id;
  final String app_name;
  String? clinic_image;

  Clinic({
    required this.id,
    required this.app_name,
    this.clinic_image,
  });

  factory Clinic.fromJSON(Map<String, dynamic> json) {
    return Clinic(
      id: json["id"],
      app_name: json["app_name"],
      clinic_image: json["clinic_image"],
    );
  }

  @override
  String toString() {
    return '''
id: $id,
app_name: $app_name,
clinic_image: $clinic_image
''';
  }
}

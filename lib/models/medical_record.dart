class MedicalRecord {
  final String title;
  final String type;
  final String petName;
  final String date;

  MedicalRecord({
    required this.title,
    required this.type,
    required this.petName,
    required this.date,
  });

  factory MedicalRecord.fromJSON(Map<String, dynamic> json) {
    return MedicalRecord(
      title: json["title"],
      type: json["type"],
      petName: json["petName"],
      date: json["date"],
    );
  }

  @override
  String toString() {
    return '''
title: $title,
type: $type,
petName: $petName,
date: $date,
''';
  }
}

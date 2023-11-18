class PetFile {
  final int id;
  final String petId;
  final String filename;
  final String filePath;
  final String createdAt;
  final String updatedAt;

  PetFile({
    required this.id,
    required this.petId,
    required this.filename,
    required this.filePath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PetFile.fromJSON(Map<String, dynamic> json) {
    return PetFile(
      id: json["id"],
      petId: json["pet_id"],
      filename: json["filename"],
      filePath: json["file_path"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  @override
  String toString() {
    return ''' {
id: $id,
petId: $petId,
filename: $filename,
filePath: $filePath,
createdAt: $createdAt,
updatedAt: $updatedAt,
    }
''';
  }
}

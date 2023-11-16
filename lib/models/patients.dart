class Patient {
  final String modeDeVie;
  final String alimentation;
  final String comment;
  final String color;
  final String identificationDate;
  final String birthDate;
  final String species;
  final String identification;
  final String microship;
  final int weight;
  final String race;
  final String robe;
  final String sex;
  final String sterilise;
  final String fmId;
  final String userId;
  final String relanceMaladies;
  final String relanceRage;
  final String photo;
  final String insuranceDesc;
  final String insuranceName;
  final String name;
  final String email;
  final String emailBody;
  final String isEmailSent;
  final String emailSubject;
  final String webImage;
  final String dcd;

  Patient({
    required this.modeDeVie,
    required this.alimentation,
    required this.comment,
    required this.color,
    required this.identificationDate,
    required this.birthDate,
    required this.species,
    required this.identification,
    required this.microship,
    required this.weight,
    required this.race,
    required this.robe,
    required this.sex,
    required this.sterilise,
    required this.fmId,
    required this.userId,
    required this.relanceMaladies,
    required this.relanceRage,
    required this.photo,
    required this.insuranceDesc,
    required this.insuranceName,
    required this.name,
    required this.email,
    required this.emailBody,
    required this.isEmailSent,
    required this.emailSubject,
    required this.webImage,
    required this.dcd,
  });

  factory Patient.fromJSON(Map<String, dynamic> json) {
    return Patient(
      modeDeVie: json["mode_de_vie"],
      alimentation: json["alimentation"],
      comment: json["comment"],
      color: json["color"],
      identificationDate: json["identification_date"],
      birthDate: json["birth_date"],
      species: json["species"],
      identification: json["identification"],
      microship: json["microship"],
      weight: json["weight"],
      race: json["race"],
      robe: json["robe"],
      sex: json["sex"],
      sterilise: json["sterilise"],
      fmId: json["fm_id"],
      userId: json["user_id"],
      relanceMaladies: json["relance_maladies"],
      relanceRage: json["relance_rage"],
      photo: json["photo"],
      insuranceDesc: json["insurance_desc"],
      insuranceName: json["insurance_name"],
      name: json["name"],
      email: json["email"],
      emailBody: json["email_body"],
      isEmailSent: json["is_email_sent"],
      emailSubject: json["email_subject"],
      webImage: json["web_image"],
      dcd: json["dcd"],
    );
  }

  @override
  String toString() {
    return ''' {
modeDeVie: $modeDeVie,
alimentation: $alimentation,
comment: $comment,
color: $color,
identificationDate: $identificationDate,
birthDate: $birthDate,
species: $species,
identification: $identification,
microship: $microship,
weight: $weight,
race: $race,
robe: $robe,
sex: $sex,
sterilise: $sterilise,
fmId: $fmId,
userId: $userId,
relanceMaladies: $relanceMaladies,
relanceRage: $relanceRage,
photo: $photo,
insuranceDesc: $insuranceDesc,
insuranceName: $insuranceName,
name: $name,
email: $email,
emailBody: $emailBody,
isEmailSent: $isEmailSent,
emailSubject: $emailSubject,
webImage: $webImage,
dcd: $dcd,
    }

''';
  }
}

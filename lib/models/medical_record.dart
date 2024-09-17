class MedicalRecord {
  final String med_id;
  final String exam_date;
  final String date_rapport_medical;
  final String facturation_id;
  final String user_id;
  final String pet_id;
  final String medical_record_title;
  final String med_type;
  final String report_type;
  final int Webapp_Filter_View;
  final String BIOCHIMIE;
  final String HEMATOLOGIE;
  final String PJ;
  final String REPORT;
  final String VIGNETTE;
  final String list_fichierDocument;
  final String medicalS3FilFilesListOfS3path;
  final String expires_date;
  final String pet_name;
  final String medicalPatientIDPADescriptionPatientImage;
  final String Webapp_URL_Temp;
  final String url;
  final String download_url;

  MedicalRecord({
    required this.med_id,
    required this.exam_date,
    required this.date_rapport_medical,
    required this.facturation_id,
    required this.user_id,
    required this.pet_id,
    required this.medical_record_title,
    required this.med_type,
    required this.report_type,
    required this.Webapp_Filter_View,
    required this.BIOCHIMIE,
    required this.HEMATOLOGIE,
    required this.PJ,
    required this.REPORT,
    required this.VIGNETTE,
    required this.list_fichierDocument,
    required this.medicalS3FilFilesListOfS3path,
    required this.expires_date,
    required this.pet_name,
    required this.medicalPatientIDPADescriptionPatientImage,
    required this.Webapp_URL_Temp,
    required this.url,
    required this.download_url,
  });

  factory MedicalRecord.fromJSON(Map<String, dynamic> json) {
    return MedicalRecord(
        med_id: json["med_id"],
        exam_date: json["exam_date"],
        date_rapport_medical: json["date_rapport_médical"],
        facturation_id: json["facturation_id"],
        user_id: json["user_id"],
        pet_id: json["pet_id"],
        medical_record_title: json["medical_record_title"],
        med_type: json["med_type"],
        report_type: json["report_type"],
        Webapp_Filter_View: json["Webapp_Filter_View"],
        BIOCHIMIE: json["BIOCHIMIE"],
        HEMATOLOGIE: json["HEMATOLOGIE"],
        PJ: json["PJ"],
        REPORT: json["REPORT"],
        VIGNETTE: json["VIGNETTE"],
        list_fichierDocument: json["list_fichierDocument"],
        medicalS3FilFilesListOfS3path:
            json["medical.S3.FIL_Files::list_of_s3path_u_hardCoded"],
        expires_date: json["expires_date"],
        pet_name: json["pet_name"],
        medicalPatientIDPADescriptionPatientImage:
            json["web_image"],
        Webapp_URL_Temp: json["Webapp_URL_Temp"],
        url: json["url"],
        download_url: json["download_url"]);
  }

  @override
  String toString() {
    return '''
med_id: $med_id,
exam_date: $exam_date,
date_rapport_medical: $date_rapport_medical,
facturation_id: $facturation_id,
user_id: $user_id,
pet_id: $pet_id,
medical_record_title: $medical_record_title,
med_type: $med_type,
report_type: $report_type,
Webapp_Filter_View: $Webapp_Filter_View,
BIOCHIMIE: $BIOCHIMIE,
HEMATOLOGIE: $HEMATOLOGIE,
PJ: $PJ,
REPORT: $REPORT,
VIGNETTE: $VIGNETTE,
list_fichierDocument: $list_fichierDocument,
medicalS3FilFilesListOfS3path:
    $medicalS3FilFilesListOfS3path,
expires_date: $expires_date,
pet_name: $pet_name,
medicalPatientIDPADescriptionPatientImage:
    $medicalPatientIDPADescriptionPatientImage,
Webapp_URL_Temp: $Webapp_URL_Temp,
url: $url,
download_url: $download_url";
''';
  }
}

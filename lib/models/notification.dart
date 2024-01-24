class NotificationModel {
  final String body;
  final String category;
  final String date;
  final String detail;
  final String status;
  final String subject;
  final String time;
  final int body_Count_Caracter;
  final String created_on;
  final String fm_id;
  final String user_id;
  final String pet_id;
  final String phone;

  NotificationModel(
      {required this.body,
      required this.category,
      required this.date,
      required this.detail,
      required this.status,
      required this.subject,
      required this.time,
      required this.body_Count_Caracter,
      required this.created_on,
      required this.fm_id,
      required this.user_id,
      required this.pet_id,
      required this.phone});

  factory NotificationModel.fromJSON(Map<String, dynamic> json) {
    return NotificationModel(
      body: json["body"],
      category: json["category"],
      date: json["date"],
      detail: json["detail"],
      status: json["status"],
      subject: json["subject"],
      time: json["time"],
      body_Count_Caracter: json["Body_Count_Caracter"],
      created_on: json["created_on"],
      fm_id: json["fm_id"],
      user_id: json["user_id"],
      pet_id: json["pet_id"],
      phone: json["phone"],
    );
  }

  @override
  String toString() {
    return '''
body: $body,
category: $category,
date: $date,
detail: $detail,
status: $status,
subject: $subject,
time: $time,
Body_Count_Caracter: $body_Count_Caracter,
created_on: $created_on,
fm_id: $fm_id,
user_id: $user_id,
pet_id: $pet_id,
phone: $phone,
''';
  }
}

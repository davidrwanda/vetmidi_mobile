class User {
  final String firstName;
  final String lastName;
  final String email;
  final String mobile_device;
  final String address;
  final String city;
  final String phone;
  final String fax;
  final String profession;
  final String postalCode;
  final String featureImage;
  final bool userVerified;
  final bool passwordChange;
  final String lastForgotPassword;
  final int sentVerificationEmail;
  final String lastLogin;
  final String contactWithEmail;
  final String contactWithSMS;
  final String contactWithWhatsapp;
  final bool isNewUser;
  final int? isAdmin;
  final String? referantDescription;
  final String? title;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile_device,
    required this.address,
    required this.city,
    required this.phone,
    required this.fax,
    required this.profession,
    required this.postalCode,
    required this.featureImage,
    required this.userVerified,
    required this.passwordChange,
    required this.lastForgotPassword,
    required this.sentVerificationEmail,
    required this.lastLogin,
    required this.contactWithEmail,
    required this.contactWithSMS,
    required this.contactWithWhatsapp,
    required this.isNewUser,
    this.isAdmin,
    this.referantDescription,
    this.title,
  });

  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      mobile_device: json["mobile_device"],
      address: json["address"],
      city: json["city"],
      phone: json["phone"],
      fax: json["fax"],
      profession: json["profession"],
      postalCode: (json["postal_code"]).toString(),
      featureImage: json["feature_image"],
      userVerified: json["user_verified"],
      passwordChange: json["password_change"],
      lastForgotPassword: json["last_forgot_password"],
      sentVerificationEmail: json["sent_verification_email"],
      lastLogin: json["last_login"],
      contactWithEmail: json["contact_with_email"],
      contactWithSMS: json["contact_with_sms"],
      contactWithWhatsapp: json["contact_with_whatsapp"],
      isNewUser: json["is_new_user"],
      isAdmin: json["is_admin"],
    );
  }

  factory User.fromJSONCustom(Map<String, dynamic> json) {
    return User(
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      mobile_device: json["mobile_device"],
      address: json["address"],
      city: json["city"],
      phone: json["phone"],
      fax: json["fax"],
      profession: json["profession"],
      postalCode: json["postalCode"],
      featureImage: json["featureImage"],
      userVerified: json["userVerified"],
      passwordChange: json["passwordChange"],
      lastForgotPassword: json["lastForgotPassword"],
      sentVerificationEmail: json["sentVerificationEmail"],
      lastLogin: json["lastLogin"],
      contactWithEmail: json["contactWithEmail"],
      contactWithSMS: json["contactWithSMS"],
      contactWithWhatsapp: json["contactWithWhatsapp"],
      isNewUser: json["isNewUser"],
      isAdmin: json["isAdmin"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobile_device': mobile_device,
      'address': address,
      'city': city,
      'phone': phone,
      'fax': fax,
      'profession': profession,
      'postalCode': postalCode,
      'featureImage': featureImage,
      'userVerified': userVerified,
      'passwordChange': passwordChange,
      'lastForgotPassword': lastForgotPassword,
      'sentVerificationEmail': sentVerificationEmail,
      'lastLogin': lastLogin,
      'contactWithEmail': contactWithEmail,
      'contactWithSMS': contactWithSMS,
      'contactWithWhatsapp': contactWithWhatsapp,
      'isNewUser': isNewUser,
      'isAdmin': isAdmin,
    };
  }

  @override
  String toString() {
    return ''' {
firstName: $firstName,
lastName: $lastName,
email: $email,
mobile_device: $mobile_device,
address: $address,
city: $city,
phone: $phone,
fax: $fax,
profession: $profession,
postalCode: $postalCode,
featureImage: $featureImage,
userVerified: $userVerified,
passwordChange: $passwordChange,
lastForgotPassword: $lastForgotPassword,
sentVerificationEmail: $sentVerificationEmail,
lastLogin: $lastLogin,
contactWithEmail: $contactWithEmail,
contactWithSMS: $contactWithSMS,
contactWithWhatsapp: $contactWithWhatsapp,
isNewUser: $isNewUser,
isAdmin: $isAdmin,
  }
''';
  }
}

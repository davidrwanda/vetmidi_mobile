class Profile {
  final String firstName;
  final String lastName;
  final String email;
  final String address;
  final String pays;
  final String city;
  final String phone;
  final String fax;
  final String profession;
  final String postalCode;
  final String featureImage;
  final bool userVerified;
  final bool passwordChange;
  String? lastForgotPassword;
  final int sentVerificationEmail;
  final String lastLogin;
  final String contactWithEmail;
  final String contactWithSMS;
  final String contactWithWhatsapp;
  final bool isNewUser;
  final String referantDescription;
  final String title;
  final String configId;

  Profile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.pays,
    required this.city,
    required this.phone,
    required this.fax,
    required this.profession,
    required this.postalCode,
    required this.featureImage,
    required this.userVerified,
    required this.passwordChange,
    this.lastForgotPassword,
    required this.sentVerificationEmail,
    required this.lastLogin,
    required this.contactWithEmail,
    required this.contactWithSMS,
    required this.contactWithWhatsapp,
    required this.isNewUser,
    required this.referantDescription,
    required this.title,
    required this.configId,
  });

  factory Profile.fromJSON(Map<String, dynamic> json) {
    return Profile(
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      address: json["address"],
      pays: json["pays"],
      city: json["city"],
      phone: json["phone"],
      fax: json["fax"],
      profession: json["profession"],
      postalCode: json["postal_code"].toString(),
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
      referantDescription: json["referant_description"],
      title: json["title"],
      configId: json["config_id"],
    );
  }

  @override
  String toString() {
    return ''' {
firstName: $firstName,
lastName: $lastName,
email: $email,
address: $address,
pays: $pays,
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
referantDescription: $referantDescription,
title: $title,
configId: $configId,
  }
''';
  }

  // Add this method to print all details
  void printDetails() {
    print('''
Profile Details:
  First Name: $firstName
  Last Name: $lastName
  Email: $email
  Address: $address
  Pays: $pays
  City: $city
  Phone: $phone
  Fax: $fax
  Profession: $profession
  Postal Code: $postalCode
  Feature Image: $featureImage
  User Verified: $userVerified
  Password Change: $passwordChange
  Last Forgot Password: $lastForgotPassword
  Sent Verification Email: $sentVerificationEmail
  Last Login: $lastLogin
  Contact With Email: $contactWithEmail
  Contact With SMS: $contactWithSMS
  Contact With WhatsApp: $contactWithWhatsapp
  Is New User: $isNewUser
  Referant Description: $referantDescription
  Title: $title
  Config ID: $configId
    ''');
  }
}

class Config {
  final int id;
  final String address;
  final String phone;
  final String appName;

  Config({
    required this.id,
    required this.address,
    required this.phone,
    required this.appName,
  });

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      id: json['id'],
      address: json['address'],
      phone: json['phone'],
      appName: json['app_name'],
    );
  }
  
}

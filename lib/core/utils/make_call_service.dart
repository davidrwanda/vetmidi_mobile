import 'package:url_launcher/url_launcher.dart';

launchDialer(String phoneNumber) async {
  await launchUrl(Uri(scheme: 'tel', path: phoneNumber));
}

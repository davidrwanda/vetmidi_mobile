import 'package:get/get.dart';
import 'package:intl/intl.dart';

String getTranslationKeys(String value) {
  switch (value) {
    case 'yes':
      return "page.general.yes";
    case 'oui':
      return "page.general.yes";
    case 'no':
      return "page.general.no";
    case 'non':
      return "page.general.no";
    case 'Cat':
      return "page.type.CT";
    case 'Dog':
      return "page.type.CN";
    case 'Rabbit':
      return "page.type.LP";
    case 'guinea pig':
      return "page.type.GP";
    case 'bird':
      return "page.type.OI";
    case 'Hamster':
      return "page.type.HAM";
    case 'Exotic':
      return "page.type.NAC";
    case 'Reptile':
      return "page.type.REP";
    case 'Recommandé par un ami':
      return "page.referant.byfriend";
    case 'Local / Recherche':
      return "page.referant.bylocal";
    case 'Vétérinaire traitant':
      return "page.referant.byvet1";
    case 'Facebook / Instagram':
      return "page.referant.byfbc";
    case 'Google Adwords':
      return 'page.referant.bygads';
    case 'Vétérinaire Fermé':
      return "page.referant.byvt2";
    case 'Madame':
      return "page.general.madame";
    case 'Monsieur':
      return "page.general.monsieur";
    case 'Mademoiselle':
      return "page.general.mademoiselle";
    case 'Madam':
      return "page.general.madame";
    case 'Sir':
      return "page.general.monsieur";
    case 'Miss':
      return "page.general.mademoiselle";
    case 'France':
      return "page.general.france";
    case 'Suisse':
      return "page.general.suisse";
    case 'Italie':
      return 'page.general.Italie';
    case 'Allemagne':
      return 'page.general.Allemagne';
    case 'Switzerland':
      return "page.general.suisse";
    case 'Italy':
      return 'page.general.Italie';
    case 'Germany':
      return 'page.general.Allemagne';
    default:
      return "";
  }
}

String getTitleFrenchValue(String? value) {
  switch (value) {
    case "page.general.madame":
      return 'Madame';
    case "page.general.monsieur":
      return 'Monsieur';
    case "page.general.mademoiselle":
      return 'Mademoiselle';
  }
  return "Monsieur";
}

String getCountryFrenchValue(String? value) {
  switch (value) {
    case "page.general.france":
      return 'France';
    case "page.general.suisse":
      return 'Suisse';
    case 'page.general.Italie':
      return 'Italie';
    case 'page.general.Allemagne':
      return 'Allemagne';
  }
  return "Monsieur";
}

String getYesOrNoValue(String value) {
  return value.toLowerCase() == "page.general.yes" ? "OUI" : "NON";
}

String getReferalFrenchValue(String? value) {
  switch (value) {
    case "page.referant.byfriend":
      return "Recommandé par un ami";
    case "page.referant.bygads":
      return "Google Adwords";
    case "page.referant.bylocal":
      return "Local / Recherche";
    case "page.referant.byvet1":
      return "Vétérinaire traitant";
    case "page.referant.byfbc":
      return "Facebook / Instagram";
    case "page.referant.byvt2":
      return "Vétérinaire Fermé";
    default:
      return "Recommandé par un ami";
  }
}

String formatFileSize(int fileSizeInBytes) {
  const int kb = 1024;
  const int mb = kb * 1024;
  const int gb = mb * 1024;

  if (fileSizeInBytes < kb) {
    return '$fileSizeInBytes B';
  } else if (fileSizeInBytes < mb) {
    final double sizeInKB = fileSizeInBytes / kb;
    return '${sizeInKB.round()} KB';
  } else if (fileSizeInBytes < gb) {
    final double sizeInMB = fileSizeInBytes / mb;
    return '${sizeInMB.round()} MB';
  } else {
    final double sizeInGB = fileSizeInBytes / gb;
    return '${sizeInGB.round()} GB';
  }
}

String formatDateTime(String dateTimeString) {
  String locale = 'page.locale'.tr;
  DateTime dateTime = DateFormat("MM/dd/yyyy HH:mm:ss").parse(dateTimeString);
  if (locale == 'fr') {
    return DateFormat("d MMM yyyy '|' HH'h'mm", 'fr_FR').format(dateTime);
  } else {
    return DateFormat("MMM d, yyyy | hh:mm a").format(dateTime);
  }
}

bool validateEmail(String email) {
  // Regular expression for validating email addresses
  final RegExp emailRegex = RegExp(
    r'^[\w\+-]+(\.[\w\+-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
  );

  return emailRegex.hasMatch(email);
}

bool validatePassword(String password) {
  // Regular expression for validating passwords
  final RegExp passwordRegex = RegExp(
    r'^(?=.*?[a-z])(?=.*?[#?!@)($%^&*-]).{5,}$',
  );

  return passwordRegex.hasMatch(password);
}

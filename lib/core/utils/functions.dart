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
    case 'cat':
      return "page.type.CT";
    case 'dog':
      return "page.type.CN";
    case 'rabbit':
      return "page.type.LP";
    case 'guinea pig':
      return "page.type.GP";
    case 'bird':
      return "page.type.OI";
    case 'hamster':
      return "page.type.HAM";
    case 'exotic':
      return "page.type.NAC";
    case 'reptile':
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

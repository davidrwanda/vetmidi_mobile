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
    case 'Vétérinaire Fermé':
      return "page.referant.byvt2";
    default:
      return "";
  }
}

String getYesOrNoValue(String value) {
  return getTranslationKeys(value.toLowerCase()) == "page.general.yes"
      ? "OUI"
      : "NON";
}

String formatFileSize(int fileSizeInBytes) {
  const int KB = 1024;
  const int MB = KB * 1024;
  const int GB = MB * 1024;

  if (fileSizeInBytes < KB) {
    return '$fileSizeInBytes B';
  } else if (fileSizeInBytes < MB) {
    final double sizeInKB = fileSizeInBytes / KB;
    return '${sizeInKB.round()} KB';
  } else if (fileSizeInBytes < GB) {
    final double sizeInMB = fileSizeInBytes / MB;
    return '${sizeInMB.round()} MB';
  } else {
    final double sizeInGB = fileSizeInBytes / GB;
    return '${sizeInGB.round()} GB';
  }
}

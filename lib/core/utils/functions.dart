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
    default:
      return "";
  }
}

String getYesOrNoValue(String value) {
  return getTranslationKeys(value.toLowerCase()) == "page.general.yes"
      ? "OUI"
      : "NON";
}

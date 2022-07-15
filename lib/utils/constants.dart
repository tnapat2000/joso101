class ApiConstant {
  static const String baseUrl = 'https://exat-man.web.app';
  static const String accidentEndpoint = "/api/EXAT_Accident/2565/";

  static String getAccidentInfoPage(int pageNum) {
    return accidentEndpoint + "$pageNum";
  }
}

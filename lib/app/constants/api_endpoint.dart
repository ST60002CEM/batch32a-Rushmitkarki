class ApiEndPoints {
  ApiEndPoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = 'http://10.0.2.2:5000/api/';
  // static const String baseUrl = 'http://192.168.137.1:5000/api/';

  // --------------------------Auth Routes--------------------------
  static const String loginUser = "user/login";
  static const String registerUser = "user/create";

  // --------------------------Doctor Routes--------------------------
  static const String getDoctors = "doctor/get_all_doctors";
  static const String paginationDoctors = "doctor/pagination";
  static const String doctorImageUrl = "http://10.0.2.2:5000/doctors/";
}

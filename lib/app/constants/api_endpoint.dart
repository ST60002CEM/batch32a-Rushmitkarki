class ApiEndPoints {
  ApiEndPoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // static const String baseUrl = 'http://10.0.2.2:5000/api/';
  static const String baseUrl = 'http://172.26.0.69:5000/api/';

  // --------------------------Auth Routes--------------------------
  static const String loginUser = "user/login";
  static const String registerUser = "user/create";
  static const String getMe = "user/get_single_user";
  static const String getToken = "user/generate_token";
  static const String verifyUser = 'user/Verify';

  // --------------------------Doctor Routes--------------------------
  static const String getDoctors = "doctor/get_all_doctors";
  static const String paginationDoctors = "doctor/pagination";
  static const String doctorImageUrl = "http://172.26.0.69:5000/doctors/";
}

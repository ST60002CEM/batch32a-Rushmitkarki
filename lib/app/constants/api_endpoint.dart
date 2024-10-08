class ApiEndPoints {
  ApiEndPoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);

  static const String baseUrl = 'http://192.168.1.77:5000/api/';

  // static const String baseUrl = 'http://192.168.137.1:5000/api/';

  // --------------------------Auth Routes--------------------------
  static const String loginUser = "user/login";
  static const String registerUser = "user/create";
  static const String getMe = "user/get_single_user";
  static const String getToken = "user/generate_token";
  static const String verifyUser = 'user/Verify';
  static const String forgetpassword = 'user/forget_password';
  static const String resetpassword = 'user/reset_password';
  static const String updateProfile = 'user/update_profile';
  static const String profilepicture = 'user/profile_picture';
  static const String imageUrlprofile =
      "http://192.168.137.1:5000/profile_pictures/";

  static const String googleLogin = "user/google";
  static const String getUserByGoogleEmail = "user/getGoogleUser";

  static const String searchUser = 'user/search_users';

  // --------------------------Doctor Routes--------------------------
  static const String getDoctors = "doctor/get_all_doctors";
  static const String paginationDoctors = "doctor/pagination";

  static const String doctorImageUrl = "http://192.168.1.77:5000/doctors/";

  // static const String doctorImageUrl = "http://192.168.137.1:5000/doctors/";

// -------------------------------Appointment Route---------------------------
  static const String createAppointment = "booking/create_appointments";
  static const String getUsersWithAppointments =
      "booking/users_with_appointments";
  static const String getAppointmentById = "booking/appointments";
  static const String updateAppointment = "booking/update_appointments";
  static const String deleteAppointment = "booking/delete_appointments";
  static const String approveAppointment = "booking/approve_appointment";
  static const String cancelAppointment = "booking/cancel_appointment";

  // ------------------------------Favourite Doctors---------------------------
  static const String getUserFavorites = 'favourite/all';
  static const String addFavorite = 'favourite/add';
  static const String deleteFavorite = 'favourite/delete/';

// ----------------------------review-----------------------------
  static const String addreview = 'rating/add';
  static const String getreview = 'rating/doctor';

  // --------------------------insurance--------------------------
  static const String createInsurance = 'insurance/create';
  static const String getInsurance = 'insurance/get_all_insurances';
  static const String getInsuranceById = 'insurance/get_single_insurance';
  static const String deleteInsurance = 'insurance/delete_insurance';
  static const String insuranceImageUrl = "http://192.168.1.77:5000/insurance/";

  //----------------------------chat---------------------------------
  static const String createChat = 'chat/create';
  static const String getChat = 'chat/fetch';
  static const String createGroup = 'chat/group';
  static const String rename = 'chat/rename';
  static const String addGroup = 'chat/groupadd';
  static const String removeGroup = 'chat/groupremove';
  static const String groupLeave = 'chat/groupleave';

//   ____________________________message_____________________________
  static const String sendMessage = 'message/send';
  static const String allMessage = 'message/';

//   _____________________________khalti________________________________
  static const String khalti = 'payment/initialize_khalti';
  static const String completepayment = 'payment/complete-khalti-payment';
}

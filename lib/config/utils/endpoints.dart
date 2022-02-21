class EndPoints {
  EndPoints._();

  // base url
  static const String baseURL = 'http://178.62.55.81';

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // register user endpoints
  static const String registerUser = baseURL + "/api/users/";

  // login user endpoints
  static const String loginUser = baseURL + '/api/auth/';

  // create fundraiser endpoints
  static const String fundraises = baseURL + '/api/fundraisers/';

  // categories endpoints
  static const String categories = baseURL + '/api/categories/';

  // get popular fundraiser endpoints;
  static const String popularFundraisers =
      baseURL + '/api/fundraisers/popular/';

  //get fundraiser by userID endpoints
  static const String userFundraisrs = baseURL + '/api/fundraisers/user/';

  // post an update endpoints
  static const String postUpdate = baseURL + '/api/donations/';

  // post teammember endpoints
  static const String teamMember = baseURL + '/api/members/';

  // notifications endpoints
  static const String notificaions = baseURL + '/api/notifications/';

  // single User
  static const String singleUser = baseURL + "/api/users/me";

  // image url
  static const String imageURL = baseURL + "/api/image";

  // create update
  static const String createUpdate = baseURL + "/api/updates/";

  // create donation
  static const String createDonation = baseURL + "/api/donations/";

  // create team member
  static const String createTeamMember = baseURL + "/api/members/";

  // vrifye team member invitation
  static const String verifyInvitaion =
      baseURL + "/api/fundraisers/invitation/";

  // create team member
  static const String teamMemberFundraises =
      baseURL + "/api/fundraisers/member/";

  // create withdrawal
  static const String withdrawalUrl = baseURL + "/api/withdrawal/";

  // search url
  static const String searchURL = baseURL + '/api/fundraisers/title/';

  // forget password
  static const String forgotPasswordURL = baseURL + '/api/users/forget/';

  // reset password
  static const String resetPasswordURL = baseURL + '/api/users/reset/';

  // paypal url
  static const String paypalUrl = baseURL + "/api/donation/pay/";

  //withdrawal invitation
  static const String inviteUrl =
      baseURL + "/api/withdrawal/beneficiary/invitation/";

// help URL
  static const String helpURL = baseURL + "/api/help";

  // beneficiary fundraiser URL
  static const String benficiaryFundraiserURL =
      baseURL + '/api/fundraisers/beneficiary';

  // report fundraisers
  static const String reportFundraiserURL = baseURL + "/api/report";

  // currency Strong
  static const String currencyURL =
      "https://free.currconv.com/api/v7/convert?q=USD_ETB&compact=ultra&apiKey=320b48a5bd4a198cd402";

  // report reason
  static const String reportReasonURL = baseURL + "/api/reasons";

  // payment return back url 
  static const String paymentReturnURL = "http://178.62.55.81/api/donation/success";
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? paymentMethods;
  String? phoneNumber;
  bool? emailNotification;
  bool? isDeactivated;
  bool? isAdmin;
  bool? isVerified;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phoneNumber,
    this.paymentMethods,
    this.emailNotification,
    this.isDeactivated,
    this.isAdmin,
    this.isVerified,
  });

  User copyWith(
      {String? id,
      String? firstName,
      String? lastName,
      String? email,
      String? password,
      String? paymentMethods,
      String? phoneNumber,
      bool? emailNotification,
      bool? isDeactivated,
      bool? isAdmin,
      bool? isVerified}) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      emailNotification: emailNotification ?? this.emailNotification,
      isDeactivated: isDeactivated ?? this.isDeactivated,
      isAdmin: isAdmin ?? this.isAdmin,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  factory User.fromJson(Map<String, dynamic> data) {
    print("user is $data");
    String id = data['_id'] ?? '';
    String firstName = data['firstName'] ?? '';
    String lastName = data['lastName'] ?? '';
    String email = data['email'] ?? '';
    String paymentMethods = data['paymentMethods'] ?? '';
    bool emailNotification = data['emailNotification'] ?? false;
    bool isDeactivated = data['isDeactivated'] ?? false;
    bool isAdmin = data['isAdmin'] ?? false;
    String phoneNumber = data['phoneNumber'] ?? '';
    bool isVerified = data['isVerified'] ?? false;

    return User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      paymentMethods: paymentMethods,
      emailNotification: emailNotification,
      isDeactivated: isDeactivated,
      isAdmin: isAdmin,
      phoneNumber: phoneNumber,
      isVerified: isVerified,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'emailNotification': emailNotification ?? false,
      'isDeactivated': isDeactivated ?? false,
      'isAdmin': isAdmin ?? false,
    };
  }

  @override
  String toString() {
    return '''User{
      firstName: $firstName,
      lastName: $lastName,
      email: $email,
      password: $password,
      paymentMethods: $paymentMethods,
      emailNotification: $emailNotification,
      isDeactivated': $isDeactivated,
      isAdmin: $isAdmin,
      isVerified: $isVerified
      ,}
     ''';
  }
}

class Response<T> {
  ResponseStatus status;
  T data;
  String message;

  Response({
    required this.status,
    required this.data,
    required this.message,
  });
}

enum ResponseStatus {
  LOADING,
  CONNECTIONERROR,
  FORMATERROR,
  SUCCESS,
  MISMATCHERROR,
  
}

enum AuthStatus {
  NOTLOGGEDIN,
  NOTREGISTERED,
  LOGGEDIN,
  REGISTERED,
  AUTHENTICATING,
  REGISTERING,
  LOGGEDOUT,
}

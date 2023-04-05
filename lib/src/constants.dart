/// This file contains all the constants used in the app

/// This enum is used to determine the state of the result of a request
enum ReturnState {
  success,
  incorrect,
  fail,
  other,
}

/// This class contains all the constants used in the app
class Constants {
  /// The base url of the API
  static const baseUrl = 'https://api.gitbook.com/v1/';

  /// The headers used for authentication
  static Map<String, String> getAuthHeader(final String token) {
    return <String, String>{'Authorization': 'Bearer $token'};
  }

  /// Returns the state of the result of a request
  static ReturnState getResultState(final int statusCode) {
    if (_isSucceded(statusCode)) {
      return ReturnState.success;
    } else if (_isIncorrect(statusCode)) {
      return ReturnState.incorrect;
    } else if (_isFailed(statusCode)) {
      return ReturnState.fail;
    } else {
      return ReturnState.other;
    }
  }

  /// Returns whether the status code is a success
  /// A success is a status code between 200 and 300
  static bool _isSucceded(int statusCode) =>
      statusCode >= 200 && statusCode < 300;

  /// Returns whether the status code is an incorrect request
  /// An incorrect request is a status code between 400 and 500
  static bool _isIncorrect(int statusCode) =>
      statusCode >= 400 && statusCode < 500;

  /// Returns whether the status code is a failure
  /// A failure is a status code between 500 and 600
  static bool _isFailed(int statusCode) =>
      statusCode >= 500 && statusCode < 600;
}

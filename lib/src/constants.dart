enum ReturnState {
  success,
  incorrect,
  fail,
  other,
}

class Constants {
  static const baseUrl = 'https://api.gitbook.com/v1/';

  static Map<String, String> getAuthHeader(final String token) {
    return <String, String>{'Authorization': 'Bearer $token'};
  }

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

  static bool _isSucceded(int statusCode) =>
      statusCode >= 200 && statusCode < 300;
  static bool _isIncorrect(int statusCode) =>
      statusCode >= 400 && statusCode < 500;
  static bool _isFailed(int statusCode) =>
      statusCode >= 500 && statusCode < 600;
}

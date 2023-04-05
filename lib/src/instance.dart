import 'package:gitbook_search/src/client.dart';

/// GitBookSearch is a singleton class that provides access to the GitBook API.
class GitBookSearch {
  /// Returns the initialized instance of GitBookSearch.
  static GitBookSearch get instance {
    assert(
      _instance._initialized,
      'You must initialize the GitBookAPI instance before calling GitBookAPI.instance',
    );
    return _instance;
  }

  /// Shorcut for [instance].
  static GitBookSearch get I {
    assert(
      _instance._initialized,
      'You must initialize the GitBookAPI instance before calling GitBookAPI.I',
    );
    return _instance;
  }

  /// Initializes the GitBookSearch instance.
  static void initialize({
    required String token,
  }) {
    _instance._init(token);
  }

  /// Constructor.
  GitBookSearch._();

  /// Singleton instance.
  static final GitBookSearch _instance = GitBookSearch._();

  /// Whether the instance has been initialized.
  bool _initialized = false;

  /// Exposes whether the instance has been initialized.
  static bool get isInitialized => _instance._initialized;

  /// The client instance.
  late Client client;

  /// Initializes the instance.
  void _init(String token) {
    client = Client(token);
    _initialized = true;
  }

  /// Disposes the instance.
  void dispose() {
    _initialized = false;
  }
}

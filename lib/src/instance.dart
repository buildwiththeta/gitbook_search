import 'package:gitbook_search/src/client.dart';

class GitBookSearch {
  static GitBookSearch get instance {
    assert(
      _instance._initialized,
      'You must initialize the GitBookAPI instance before calling GitBookAPI.instance',
    );
    return _instance;
  }

  static GitBookSearch get I {
    assert(
      _instance._initialized,
      'You must initialize the GitBookAPI instance before calling GitBookAPI.I',
    );
    return _instance;
  }

  static Future<GitBookSearch> initialize({
    required String token,
  }) async {
    _instance._init(token);
    return _instance;
  }

  GitBookSearch._();
  static final GitBookSearch _instance = GitBookSearch._();

  bool _initialized = false;

  late Client client;

  void _init(String token) {
    client = Client(token);
    _initialized = true;
  }

  void dispose() {
    _initialized = false;
  }
}

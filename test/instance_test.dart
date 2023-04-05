import 'package:test/test.dart';
import 'package:gitbook_search/gitbook_search.dart';

void main() {
  group('GitBookSearch', () {
    test('initialize should create a new instance of Client', () {
      GitBookSearch.initialize(token: 'test-token');
      expect(GitBookSearch.I.client, isA<Client>());
    });

    test('getInstance should return the initialized instance', () {
      GitBookSearch.initialize(token: 'test-token');
      expect(GitBookSearch.instance, isNotNull);
    });

    test('dispose should reset initialized to false', () {
      GitBookSearch.initialize(token: 'test-token');
      GitBookSearch.I.dispose();
      expect(GitBookSearch.isInitialized, isFalse);
    });
  });
}

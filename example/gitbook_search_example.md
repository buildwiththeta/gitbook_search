## Example
In this example: 
- initializing the instance of GitBookSearch
- searching for a query across GitBook
- error handling of the call
- a simple example of the use of the response

```dart
import 'package:gitbook_search/gitbook_search.dart';

Future<void> main() async {
  GitBookSearch.initialize(token: 'token');
  final res = await GitBookSearch.I.client.search.query("Column widget");
  if (res.error != null) {
    print('Error, code: ${res.error?.code}, message: ${res.error?.message}');
  }
  for (final space in res.data!) {
    print('${space.pages}');
  }
}
```
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

  /// Traditional way
  final res = await GitBookSearch.I.client.search.query("...");
  if (res.error != null) {
    print('Error, code: ${res.error?.code}, message: ${res.error?.message}');
  }
  for (final space in res.data!) {
    print('${space.pages}');
  }

  /// AI-powered
  final resFromAI = await GitBookSearch.I.client.ai.ask("What's a Column widget?");
  if (resFromAI.error != null) {
    Logger.printError('Error, code: ${resFromAI.error?.code}, message: ${resFromAI.error?.message}');
  }
  final answer = resFromAI.data! as AIAnswer;
  
  /// The Column widget is used to create a vertical layout for any UI ...
  final text = answer.text;

  /// What is the Main Axis and Cross Axis in a Column widget?
  final followUpQuestions = answer.followupQuestions;

  /// The pages that contain the answer.
  final pages = answer.pages;
}
```
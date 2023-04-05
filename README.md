# GitBook search

A wrapper API for GitBook to search across pages and spaces.
Useful for Saas or products with a search bar for docs and knowledge base.

### Initialization
Initialize the client with your GitBook token. Since the initialization, you can use **GitBookSearch.I.client** or **GitBookSearch.instance.client** to access the client.
```dart
import 'package:gitbook_search/gitbook_search.dart';

void main() {
    GitBookSearch.initialize(token: 'token');

    /// Your app
}
```

### Traditional way
```dart
final res = await GitBookSearch.I.client.search.query("...");
if (res.error != null) {
    print('Error, code: ${res.error?.code}, message: ${res.error?.message}');
}
final spaces = res.data! as List<Space>;
for (final space in spaces) {
    /// Do something
}
```

### AI-powered
```dart
final res = await GitBookSearch.I.client.ai.ask("What's a Column widget?");
if (res.error != null) {
  Logger.printError('Error, code: ${res.error?.code}, message: ${res.error?.message}');
}
final answer = res.data! as AIAnswer;

/// The Column widget is used to create a vertical layout for any UI ...
final text = answer.text;

/// What is the Main Axis and Cross Axis in a Column widget?
final followUpQuestions = answer.followupQuestions;

/// The pages that contain the answer.
final pages = answer.pages;
```

## Features and bugs
- Search across pages and spaces using a String query
- AI-powered search using a natural language query
- Get a list of spaces
- Get a list of pages

#### TODO issue with AI Lens Api
AI Lens are recent and need a future update from GitBook.
At the moment, they are documented as Post requests, but they are actually Get requests.
We will update the package as soon as possible.


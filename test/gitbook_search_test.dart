import 'package:gitbook_search/gitbook_search.dart';
import 'package:light_logger/light_logger.dart';

void main() async {
  final token = 'YOUR_TOKEN';
  GitBookSearch.initialize(token: token);
  final res = await GitBookSearch.I.client.ai.ask("Column widget");
  if (res.error != null) {
    Logger.printError(
        'Error, code: ${res.error?.code}, message: ${res.error?.message}');
  }
  print(res.data);
  final answer = res.data as AIAnswer;

  /// The Column widget is used to create a vertical layout for any UI ...
  print(answer.text);

  /// What is the Main Axis and Cross Axis in a Column widget?
  print(answer.followupQuestions);

  /// The pages that contain the answer.
  print(answer.pages);

  final spaces = await GitBookSearch.I.client.getSpaces();
  if (spaces.error != null) {
    Logger.printError(
        'Error, code: ${spaces.error?.code}, message: ${spaces.error?.message}');
  }
  print(spaces.data);
}

import 'package:gitbook_search/src/instance.dart';
import 'package:light_logger/light_logger.dart';

void main() async {
  final token = '';
  GitBookSearch.initialize(token: token);
  final res = await GitBookSearch.I.client.search.query("Column widget");
  if (res.error != null) {
    Logger.printError(
        'Error, code: ${res.error?.code}, message: ${res.error?.message}');
  }
  for (final space in res.data!) {
    Logger.printMessage('${space.pages}');
  }
}

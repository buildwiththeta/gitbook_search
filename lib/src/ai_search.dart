import 'package:clear_response/clear_response.dart';
import 'package:gitbook_search/src/constants.dart';
import 'package:http/http.dart' as http;

class AISearch {
  const AISearch(this.token);

  final String token;

  Future<ClearResponse<dynamic, ClearErrorResponse?>> ask(
      final String query) async {
    final params = {
      'query': query,
    };
    final uri = Uri.parse(
      '${Constants.baseUrl}search/ask',
    ).replace(queryParameters: params);
    final res = await http.get(
      uri,
      headers: <String, String>{
        ...Constants.getAuthHeader(token),
      },
    );
    final state = Constants.getResultState(res.statusCode);
    if (state == ReturnState.success) {
      return ClearResponse(data: res.body, error: null);
    } else if (state == ReturnState.success) {
      return ClearResponse(
        data: null,
        error: ClearErrorResponse(
          code: res.statusCode,
          message: res.body,
        ),
      );
    } else {
      return ClearResponse(
        data: null,
        error: ClearErrorResponse(
          code: res.statusCode,
          message: res.body,
        ),
      );
    }
  }
}

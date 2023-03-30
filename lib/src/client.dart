import 'package:clear_response/clear_response.dart';
import 'package:gitbook_search/src/ai_search.dart';
import 'package:gitbook_search/src/constants.dart';
import 'package:gitbook_search/src/search.dart';
import 'package:http/http.dart' as http;

class Client {
  Client(
    this.token,
  )   : search = Search(token),
        ai = AISearch(token);

  final String token;
  final Search search;
  final AISearch ai;

  Future<ClearResponse<dynamic, ClearErrorResponse?>> getSpaces() async {
    final uri = Uri.parse('${Constants.baseUrl}user/spaces');
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

  Future<ClearResponse<dynamic, ClearErrorResponse?>> getSpace(
      final String spaceId) async {
    final uri = Uri.parse('${Constants.baseUrl}spaces/$spaceId');
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

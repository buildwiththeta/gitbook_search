import 'dart:convert';

import 'package:clear_response/clear_response.dart';
import 'package:gitbook_search/gitbook_search.dart';
import 'package:http/http.dart' as http;
import 'package:light_logger/light_logger.dart';

/// Client is a class that provides access to the GitBook API.
class Client {
  /// Constructor.
  Client(
    this.token, {
    final http.Client? client,
  })  : _client = client ?? http.Client(),
        search = Search(token),
        ai = AISearch(token);

  /// The token.
  final String token;

  /// The search instance.
  final Search search;

  /// The ai instance.
  final AISearch ai;

  /// The http client.
  final http.Client _client;

  /// Returns the spaces of the user.
  Future<ClearResponse<List<Space>?, ClearErrorResponse?>> getSpaces() async {
    final uri = Uri.parse('${Constants.baseUrl}user/spaces');
    final res = await _client.get(
      uri,
      headers: <String, String>{
        ...Constants.getAuthHeader(token),
      },
    );
    try {
      final state = Constants.getResultState(res.statusCode);
      if (state == ReturnState.success) {
        final doc = jsonDecode(res.body);
        final spaces = (doc['items'] as List<dynamic>)
            .map(
              (e) => Space.fromJson(e),
            )
            .toList();
        return ClearResponse(data: spaces, error: null);
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
    } catch (e) {
      Logger.printError('Error in getSpaces() method, error: $e');
      return ClearResponse(
        data: null,
        error: ClearErrorResponse(
          code: res.statusCode,
          message: e.toString(),
        ),
      );
    }
  }

  /// Returns the space with the given id.
  Future<ClearResponse<Space?, ClearErrorResponse?>> getSpace(
      final String spaceId) async {
    final uri = Uri.parse('${Constants.baseUrl}spaces/$spaceId');
    final res = await _client.get(
      uri,
      headers: <String, String>{
        ...Constants.getAuthHeader(token),
      },
    );
    try {
      final state = Constants.getResultState(res.statusCode);
      if (state == ReturnState.success) {
        final doc = jsonDecode(res.body);
        final space = Space.fromJson(doc);
        return ClearResponse(data: space, error: null);
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
    } catch (e) {
      Logger.printError('Error in getSpace() method, error: $e');
      return ClearResponse(
        data: null,
        error: ClearErrorResponse(
          code: res.statusCode,
          message: e.toString(),
        ),
      );
    }
  }
}

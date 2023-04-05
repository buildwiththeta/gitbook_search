import 'dart:convert';

import 'package:clear_response/clear_response.dart';
import 'package:gitbook_search/src/constants.dart';
import 'package:gitbook_search/src/models/page.dart';
import 'package:gitbook_search/src/models/space.dart';
import 'package:http/http.dart' as http;

/// Search is a class that provides access to the GitBook Search API.
class Search {
  /// Constructor.
  Search(
    this.token, {
    http.Client? client,
  }) : _client = client ?? http.Client();

  /// The token.
  final String token;

  /// The http client.
  final http.Client _client;

  /// Returns the spaces of the user.
  Future<ClearResponse<List<Space>?, ClearErrorResponse?>> query(
      final String query) async {
    return _search(
      '${Constants.baseUrl}search',
      queryParameters: {'query': query},
      dataKey: 'items',
      dataMapper: (json) => json
          .map(
            (e) => Space.fromJson(json),
          )
          .toList(),
    );
  }

  /// Returns the spaces of the user with the given organization id.
  Future<ClearResponse<List<Space>?, ClearErrorResponse?>> queryByOrgId(
      final String query,
      {required final String orgId}) async {
    return _search(
      '${Constants.baseUrl}orgs/$orgId/search',
      queryParameters: {'query': query},
      dataKey: 'items',
      dataMapper: (json) => json
          .map(
            (e) => Space.fromJson(json),
          )
          .toList(),
    );
  }

  /// Returns the space with the given id.
  Future<ClearResponse<List<Page>?, ClearErrorResponse?>> queryBySpaceId(
      final String query,
      {required final String spaceId}) async {
    return _search(
      '${Constants.baseUrl}spaces/$spaceId/search',
      queryParameters: {'query': query},
      dataKey: 'items',
      dataMapper: (json) => json
          .map(
            (e) => Page.fromJson(e),
          )
          .toList(),
    );
  }

  /// The `_search` method takes in the URL, query parameters, data key, and data mapper as arguments.
  /// It then performs the request and returns a `ClearResponse` object with the data mapped to the desired type.
  /// The `query`, `queryByOrgId`, and `queryBySpaceId` methods now
  /// use this `_search` method internally to reduce code duplication.
  Future<ClearResponse<T?, ClearErrorResponse?>> _search<T>(
    String url, {
    required Map<String, String> queryParameters,
    required String dataKey,
    required T Function(dynamic) dataMapper,
  }) async {
    final uri = Uri.parse(url).replace(queryParameters: queryParameters);
    final res =
        await _client.get(uri, headers: {...Constants.getAuthHeader(token)});
    try {
      final state = Constants.getResultState(res.statusCode);
      if (state == ReturnState.success) {
        final body = jsonDecode(res.body);
        if (body is Map && body.containsKey(dataKey)) {
          final data = (body[dataKey] as List<dynamic>)
              .map((e) => dataMapper(e))
              .toList();
          return ClearResponse(data: data as T, error: null);
        } else {
          return ClearResponse(
            data: null,
            error: ClearErrorResponse(
              code: res.statusCode,
              message: 'Invalid response format: $body',
            ),
          );
        }
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
      return ClearResponse(
        data: null,
        error: ClearErrorResponse(
          code: 0,
          message: e.toString(),
        ),
      );
    }
  }
}

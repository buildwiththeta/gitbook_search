import 'dart:convert';

import 'package:clear_response/clear_response.dart';
import 'package:gitbook_search/src/constants.dart';
import 'package:gitbook_search/src/models/page.dart';
import 'package:gitbook_search/src/models/space.dart';
import 'package:http/http.dart' as http;

class Search {
  const Search(this.token);

  final String token;

  Future<ClearResponse<List<Space>?, ClearErrorResponse?>> query(
      final String query) async {
    final params = {
      'query': query,
    };
    final uri = Uri.parse(
      '${Constants.baseUrl}search',
    ).replace(queryParameters: params);
    final res = await http.get(
      uri,
      headers: <String, String>{
        ...Constants.getAuthHeader(token),
      },
    );
    final state = Constants.getResultState(res.statusCode);
    if (state == ReturnState.success) {
      final body = jsonDecode(res.body);
      final spaces = (body['items'] as List<dynamic>)
          .map((e) => Space.fromJson(e))
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
  }

  Future<ClearResponse<List<Space>?, ClearErrorResponse?>> queryByOrgId(
    final String query, {
    required final String orgId,
  }) async {
    final params = {
      'query': query,
    };
    final uri = Uri.parse(
      '${Constants.baseUrl}orgs/$orgId/search',
    ).replace(queryParameters: params);
    final res = await http.get(
      uri,
      headers: <String, String>{
        ...Constants.getAuthHeader(token),
      },
    );
    final state = Constants.getResultState(res.statusCode);
    if (state == ReturnState.success) {
      final body = jsonDecode(res.body);
      final spaces = (body['items'] as List<dynamic>)
          .map((e) => Space.fromJson(e))
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
  }

  Future<ClearResponse<List<Page>?, ClearErrorResponse?>> queryBySpaceId(
    final String query, {
    required final String spaceId,
  }) async {
    final params = {
      'query': query,
    };
    final uri = Uri.parse(
      '${Constants.baseUrl}spaces/$spaceId/search',
    ).replace(queryParameters: params);
    final res = await http.get(
      uri,
      headers: <String, String>{
        ...Constants.getAuthHeader(token),
      },
    );
    final state = Constants.getResultState(res.statusCode);
    if (state == ReturnState.success) {
      final body = jsonDecode(res.body);
      final pages = (body['items'] as List<dynamic>)
          .map((e) => Page.fromJson(e))
          .toList();
      return ClearResponse(data: pages, error: null);
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

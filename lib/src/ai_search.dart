import 'dart:convert';

import 'package:clear_response/clear_response.dart';
import 'package:gitbook_search/gitbook_search.dart';
import 'package:http/http.dart' as http;

/// AI Search
class AISearch {
  /// Create an instance of [AISearch]
  AISearch(
    this.token, {
    final http.Client? client,
  }) : _client = client ?? http.Client();

  /// The token to use for authentication
  final String token;

  /// The http client to use for requests
  final http.Client _client;

  /// The previous queries that have been made to the AI
  /// This is to save queries to reuse them in the future
  static List<String> previousQueries = [];

  /// Reset the previous queries
  void resetPreviousQueries() {
    previousQueries = [];
  }

  /// Ask a question to an AI across spaces that is accessible by the currently authenticated target.
  Future<ClearResponse<AIAnswer?, ClearErrorResponse?>> ask(
    final String query,
  ) async {
    final params = {
      'query': query,
    };
    final uri = Uri.parse(
      '${Constants.baseUrl}search/ask',
    ).replace(queryParameters: params);

    /// see https://developer.gitbook.com/gitbook-api/reference/search#search-ask
    /// it's documented as a POST request, but it's actually a GET request
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
        final answer = AIAnswer.fromJson(doc['answer']);
        previousQueries.add(query);
        return ClearResponse(data: answer, error: null);
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

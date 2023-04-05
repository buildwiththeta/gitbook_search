class AIAnswer {
  const AIAnswer({
    required this.text,
    required this.followupQuestions,
    required this.pages,
  });

  final String text;
  final List<String> followupQuestions;
  final List<AIPage> pages;

  static AIAnswer fromJson(Map<String, dynamic> json) {
    return AIAnswer(
      text: json['text'],
      followupQuestions: (json['followupQuestions'] as List<dynamic>)
          .map((e) => '$e')
          .toList(),
      pages: (json['pages'] as List<dynamic>)
          .map((e) => AIPage.fromJson(e))
          .toList(),
    );
  }

  @override
  String toString() =>
      'AIAnswer { text: $text, followupQuestions: $followupQuestions, pages: $pages }';
}

class AIPage {
  const AIPage({
    required this.page,
    required this.revision,
    required this.space,
    required this.sections,
  });

  final String page;
  final String revision;
  final String space;
  final List<String> sections;

  static AIPage fromJson(Map<String, dynamic> json) {
    return AIPage(
      page: json['page'],
      revision: json['revision'],
      space: json['space'],
      sections:
          (json['sections'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }

  @override
  String toString() =>
      'AIPage { page: $page, revision: $revision, space: $space, sections: $sections }';
}

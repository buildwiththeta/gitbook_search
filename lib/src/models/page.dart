import 'package:equatable/equatable.dart';
import 'package:gitbook_search/src/models/section.dart';
import 'package:gitbook_search/src/models/url.dart';

class Page extends Equatable {
  const Page(
    this.id,
    this.title,
    this.path,
    this.sections,
    this.urls,
  );

  final String id;
  final String title;
  final String path;
  final List<Section> sections;
  final Url urls;

  static Page fromJson(Map<String, dynamic> json) {
    final urls = Url.fromJson(json['urls']);
    final sections = (json['sections'] as List<dynamic>)
        .map((e) => Section.fromJson(e))
        .toList();
    return Page(
      json['id'],
      json['title'],
      json['path'],
      sections,
      urls,
    );
  }

  @override
  List<Object> get props => [id, title, path, sections, urls];

  @override
  String toString() =>
      'Page { id: $id, title: $title, path: $path, sections: $sections, urls: $urls }';
}

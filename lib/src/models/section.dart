import 'package:equatable/equatable.dart';
import 'package:gitbook_search/src/models/url.dart';

class Section extends Equatable {
  const Section(
    this.id,
    this.title,
    this.path,
    this.body,
    this.urls,
  );

  final String id;
  final String title;
  final String path;
  final String body;
  final Url urls;

  static Section fromJson(Map<String, dynamic> json) {
    final urls = Url.fromJson(json['urls']);
    return Section(
      json['id'],
      json['title'],
      json['path'],
      json['body'],
      urls,
    );
  }

  @override
  List<Object> get props => [id, title, path, body, urls];

  @override
  String toString() =>
      'Section { id: $id, title: $title, path: $path, body: $body, urls: $urls }';
}

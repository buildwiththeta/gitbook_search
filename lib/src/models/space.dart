import 'package:equatable/equatable.dart';
import 'package:gitbook_search/src/models/page.dart';

class Space extends Equatable {
  const Space(
    this.id,
    this.title,
    this.pages,
  );

  final String id;
  final String title;
  final List<Page> pages;

  static Space fromJson(Map<String, dynamic> json) {
    final pages =
        (json['pages'] as List<dynamic>).map((e) => Page.fromJson(e)).toList();
    return Space(
      json['id'] as String,
      json['title'] as String,
      pages,
    );
  }

  @override
  List<Object> get props => [id, title];

  @override
  String toString() => 'Space { id: $id, title: $title, pages: $pages }';
}

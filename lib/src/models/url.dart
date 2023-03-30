import 'package:equatable/equatable.dart';

class Url extends Equatable {
  const Url(this.app);

  final String app;

  static Url fromJson(Map<String, dynamic> json) {
    return Url(json['app'] as String);
  }

  @override
  List<Object> get props => [app];

  @override
  String toString() => 'Url { app: $app }';
}

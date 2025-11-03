import 'dart:convert';

import 'package:devfest_bari_2025/data.dart';
import 'package:equatable/equatable.dart';

class ServerResponse extends Equatable {
  final String data;
  final ServerError error;

  const ServerResponse({
    this.data = '',
    this.error = const ServerError(),
  });

  ServerResponse copyWith({
    String? data,
    ServerError? error,
  }) {
    return ServerResponse(
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  factory ServerResponse.fromMap(Map<String, dynamic> map) {
    return ServerResponse(
      data: map['data'] as String? ?? '',
      error: ServerError.fromMap(Map<String, dynamic>.from(map['error'] ?? {})),
    );
  }

  factory ServerResponse.fromJson(String source) =>
      ServerResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [data, error];
}

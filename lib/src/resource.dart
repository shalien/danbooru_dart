import 'dart:convert';

import 'package:meta/meta.dart';

/// Base class for all resources.
@immutable
@internal
abstract base class Resource {
  /// An identifier for the resource.
  final int? id;

  /// The date and time the resource was created.
  final DateTime? createdAt;

  /// The date and time the resource was last updated.
  final DateTime? updatedAt;

  /// Creates a new [Resource].
  @internal
  @mustBeOverridden
  const Resource(this.id, this.createdAt, this.updatedAt);

  @internal
  @mustBeOverridden
  Resource.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']);

  @internal
  @mustBeOverridden
  String toJson() => jsonEncode({
        runtimeType.toString(): {
          'id': id,
          'created_at': createdAt?.millisecondsSinceEpoch.toString(),
          'updated_at': updatedAt?.millisecondsSinceEpoch.toString(),
        }
      });

  @override
  String toString() => 'Resource(id: $id, createdAt: $createdAt, '
      'updatedAt: $updatedAt)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Resource &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => id.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;
}

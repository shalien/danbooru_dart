import 'dart:convert';

import 'package:meta/meta.dart';

import '../resource.dart';

typedef TagCategory = int;

const TagCategory general = 0;
const TagCategory artist = 1;
const TagCategory copyright = 3;
const TagCategory character = 4;
const TagCategory meta = 5;

@immutable
final class Tag extends Resource {
  final String name;

  final TagCategory category;

  final int postCount;

  final bool isLocked;

  final bool isDeprecated;

  Tag(
    this.name, {
    this.category = general,
    this.postCount = 0,
    this.isLocked = false,
    this.isDeprecated = false,
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id, createdAt, updatedAt);

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      json['name'],
      category: json['category'],
      postCount: json['post_count'],
      isLocked: json['is_locked'],
      isDeprecated: json['is_deprecated'],
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  @override
  String toJson() {
    return jsonEncode({
      runtimeType.toString(): {
        'name': name,
        'category': category,
        'post_count': postCount,
        'is_locked': isLocked,
        'is_deprecated': isDeprecated,
        'id': id,
        'created_at': createdAt?.millisecondsSinceEpoch.toString(),
        'updated_at': updatedAt?.millisecondsSinceEpoch.toString(),
      },
    });
  }
}

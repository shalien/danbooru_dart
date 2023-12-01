part of '../resource.dart';

/// The category of a [Tag].
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

  @override
  const Tag(this.name,
      {this.category = general,
      this.postCount = 0,
      this.isLocked = false,
      this.isDeprecated = false})
      : super();

  @override
  const Tag._(
    this.name, {
    this.category = general,
    this.postCount = 0,
    this.isLocked = false,
    this.isDeprecated = false,
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(id, createdAt, updatedAt);

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag._(
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

  @override
  String toString() {
    return 'Tag(name: $name, category: $category, postCount: $postCount, '
        'isLocked: $isLocked, isDeprecated: $isDeprecated, id: $id, '
        'createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Tag &&
            runtimeType == other.runtimeType &&
            name == other.name &&
            category == other.category &&
            postCount == other.postCount &&
            isLocked == other.isLocked &&
            isDeprecated == other.isDeprecated &&
            id == other.id &&
            createdAt == other.createdAt &&
            updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        category.hashCode ^
        postCount.hashCode ^
        isLocked.hashCode ^
        isDeprecated.hashCode ^
        id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  @override
  Tag copyWith({
    TagCategory? category,
    bool? isLocked,
    bool? isDeprecated,
  }) {
    return Tag._(
      name,
      category: category ?? this.category,
      postCount: postCount,
      isLocked: isLocked ?? this.isLocked,
      isDeprecated: isDeprecated ?? this.isDeprecated,
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

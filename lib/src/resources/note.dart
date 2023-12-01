part of '../resource.dart';

final class Note extends Resource {
  final int postId;

  final String body;

  final int x;

  final int y;

  final int width;

  final int height;

  final bool isActive;

  final int version;

  @override
  const Note(this.postId, this.body, this.x, this.y, this.width, this.height,
      this.isActive, this.version)
      : super();

  @override
  const Note._(
      this.postId,
      this.body,
      this.x,
      this.y,
      this.width,
      this.height,
      this.isActive,
      this.version,
      int? id,
      DateTime? createdAt,
      DateTime? updatedAt)
      : super._(id, createdAt, updatedAt);

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note._(
      json['id'],
      json['post_id'],
      json['body'],
      json['x'],
      json['y'],
      json['width'],
      json['height'],
      json['is_active'],
      json['version'],
      DateTime.parse(json['created_at']),
      DateTime.parse(json['updated_at']),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Note &&
            runtimeType == other.runtimeType &&
            postId == other.postId &&
            body == other.body &&
            x == other.x &&
            y == other.y &&
            width == other.width &&
            height == other.height &&
            isActive == other.isActive &&
            version == other.version &&
            id == other.id &&
            createdAt == other.createdAt &&
            updatedAt == other.updatedAt;
  }

  @override
  Note copyWith({
    int? id,
    int? postId,
    String? body,
    int? x,
    int? y,
    int? width,
    int? height,
    bool? isActive,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Note._(
      postId ?? this.postId,
      body ?? this.body,
      x ?? this.x,
      y ?? this.y,
      width ?? this.width,
      height ?? this.height,
      isActive ?? this.isActive,
      version ?? this.version,
      id ?? this.id,
      createdAt ?? this.createdAt,
      updatedAt ?? this.updatedAt,
    );
  }

  @override
  int get hashCode =>
      postId.hashCode ^
      body.hashCode ^
      x.hashCode ^
      y.hashCode ^
      width.hashCode ^
      height.hashCode ^
      isActive.hashCode ^
      version.hashCode ^
      id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;

  @override
  String toJson() {
    return jsonEncode({
      runtimeType.toString(): {
        'id': id,
        'post_id': postId,
        'body': body,
        'x': x,
        'y': y,
        'width': width,
        'height': height,
        'is_active': isActive,
        'version': version,
        'created_at': createdAt?.millisecondsSinceEpoch.toString(),
        'updated_at': updatedAt?.millisecondsSinceEpoch.toString(),
      }
    });
  }

  @override
  String toString() {
    return 'Note{postId: $postId, body: $body, x: $x, y: $y, width: $width, height: $height, isActive: $isActive, version: $version, id: $id, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

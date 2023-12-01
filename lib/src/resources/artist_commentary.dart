part of '../resource.dart';

@immutable
final class ArtistCommentary extends Resource {
  final int? postId;

  final String originalTitle;

  final String originalDescription;

  final String translatedTitle;

  final String translatedDescription;

  @override
  const ArtistCommentary(this.originalTitle, this.originalDescription,
      this.translatedTitle, this.translatedDescription)
      : postId = null,
        super();

  @override
  const ArtistCommentary._(
      this.postId,
      this.originalTitle,
      this.originalDescription,
      this.translatedTitle,
      this.translatedDescription,
      int? id,
      DateTime? createdAt,
      DateTime? updatedAt)
      : super._(id, createdAt, updatedAt);

  factory ArtistCommentary.fromJson(Map<String, dynamic> json) {
    return ArtistCommentary._(
      json['post_id'],
      json['original_title'],
      json['original_description'],
      json['translated_title'],
      json['translated_description'],
      json['id'],
      DateTime.parse(json['created_at']),
      DateTime.parse(json['updated_at']),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ArtistCommentary &&
            runtimeType == other.runtimeType &&
            postId == other.postId &&
            originalTitle == other.originalTitle &&
            originalDescription == other.originalDescription &&
            translatedTitle == other.translatedTitle &&
            id == other.id &&
            createdAt == other.createdAt &&
            updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    return postId.hashCode ^
        originalTitle.hashCode ^
        originalDescription.hashCode ^
        translatedTitle.hashCode ^
        translatedDescription.hashCode ^
        id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  @override
  ArtistCommentary copyWith({
    String? originalTitle,
    String? originalDescription,
    String? translatedTitle,
    String? translatedDescription,
  }) {
    return ArtistCommentary._(
      postId,
      originalTitle ?? this.originalTitle,
      originalDescription ?? this.originalDescription,
      translatedTitle ?? this.translatedTitle,
      translatedDescription ?? this.translatedDescription,
      id,
      createdAt,
      updatedAt,
    );
  }

  @override
  String toString() {
    return 'ArtistCommentary{postId: $postId, originalTitle: $originalTitle, originalDescription: $originalDescription, translatedTitle: $translatedTitle, translatedDescription: $translatedDescription, id: $id, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  @override
  String toJson() {
    return jsonEncode({
      runtimeType.toString(): {
        'post_id': postId,
        'original_title': originalTitle,
        'original_description': originalDescription,
        'translated_title': translatedTitle,
        'translated_description': translatedDescription,
        'id': id,
        'created_at': createdAt?.millisecondsSinceEpoch.toString(),
        'updated_at': updatedAt?.millisecondsSinceEpoch.toString(),
      }
    });
  }
}

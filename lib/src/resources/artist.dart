import 'dart:convert';

import 'package:meta/meta.dart';

import '../resource.dart';

@immutable
final class Artist extends Resource {
  final String name;

  final String? groupName;

  final List<String>? otherNames;

  final List<Artist>? members;

  final List<Uri>? urls;

  final bool isDeleted;

  final String? wikiPage;

  final bool isBanned;

  const Artist(this.name,
      {this.groupName,
      this.isBanned = false,
      this.isDeleted = false,
      this.members,
      this.otherNames,
      this.urls,
      this.wikiPage,
      int? id,
      DateTime? createdAt,
      DateTime? updatedAt})
      : super(id, createdAt, updatedAt);

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      json['name'],
      groupName: json['group_name'],
      isBanned: json['is_banned'],
      isDeleted: json['is_deleted'],
      members: json['members'] != null
          ? (json['members'] as List).map((e) => Artist.fromJson(e)).toList()
          : null,
      otherNames: json['other_names'] != null
          ? (json['other_names'] as List<dynamic>).toList().cast<String>()
          : null,
      urls: json['urls'] != null
          ? (json['urls'] as String)
              .split(' ')
              .map((e) => Uri.parse(e))
              .toList()
          : null,
      wikiPage: json['wiki_page'],
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  @override
  String toJson() {
    /// if property can be null test before including them in the json
    return jsonEncode({
      runtimeType.toString(): {
        'name': name,
        ...groupName != null ? {'group_name': groupName} : {},
        'is_banned': isBanned,
        'is_deleted': isDeleted,
        ...members != null
            ? {'members': members?.map((e) => e.toJson()).toList()}
            : {},
        ...otherNames != null ? {'other_names': otherNames?.join(' ')} : {},
        ...urls != null
            ? {'url_string': urls?.map((e) => e.toString()).toList()}
            : {},
        ...wikiPage != null ? {'wiki_page': wikiPage} : {},
        ...id != null ? {'id': id} : {},
        ...createdAt != null
            ? {'created_at': createdAt?.millisecondsSinceEpoch.toString()}
            : {},
        ...updatedAt != null
            ? {'updated_at': updatedAt?.millisecondsSinceEpoch.toString()}
            : {},
      }
    });
  }

  @override
  String toString() {
    return 'Artist{name: $name, groupName: $groupName, otherNames: $otherNames, members: $members, urls: $urls, isDeleted: $isDeleted, wikiPage: $wikiPage, isBanned: $isBanned, id: $id, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Artist &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          groupName == other.groupName &&
          otherNames == other.otherNames &&
          members == other.members &&
          urls == other.urls &&
          isDeleted == other.isDeleted &&
          wikiPage == other.wikiPage &&
          isBanned == other.isBanned &&
          id == other.id &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      name.hashCode ^
      groupName.hashCode ^
      otherNames.hashCode ^
      members.hashCode ^
      urls.hashCode ^
      isDeleted.hashCode ^
      wikiPage.hashCode ^
      isBanned.hashCode ^
      id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}

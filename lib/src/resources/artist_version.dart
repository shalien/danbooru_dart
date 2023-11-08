import 'dart:convert';

import 'package:meta/meta.dart';

import '../resource.dart';

@immutable
final class ArtistVersion extends Resource {
  final int artistId;

  final String name;

  final List<Uri>? urls;

  final List<String>? otherNames;

  final String groupName;

  final bool isBanned;

  final int updaterId;

  final String? updaterAddrIp;

  const ArtistVersion(
      super.id,
      this.artistId,
      this.name,
      this.urls,
      this.otherNames,
      this.groupName,
      this.isBanned,
      this.updaterId,
      super.createdAt,
      super.updatedAt,
      {this.updaterAddrIp});

  factory ArtistVersion.fromJson(Map<String, dynamic> json) {
    return ArtistVersion(
      json['id'],
      json['artist_id'],
      json['name'],
      json['urls'] != null
          ? (json['urls'] as String)
              .split(' ')
              .map((e) => Uri.parse(e))
              .toList()
          : null,
      json['other_names'] != null
          ? (json['other_names'] as List<dynamic>).toList().cast<String>()
          : null,
      json['group_name'],
      json['is_banned'],
      json['updater_id'],
      DateTime.parse(json['created_at']),
      DateTime.parse(json['updated_at']),
      updaterAddrIp: json['updater_addr_ip'],
    );
  }

  @override
  String toJson() {
    return jsonEncode({
      'artist_version': {
        'id': id,
        'artist_id': artistId,
        'name': name,
        'urls': urls?.map((e) => e.toString()).join(' '),
        'other_names': otherNames?.join(' '),
        'group_name': groupName,
        'is_banned': isBanned,
        'updater_id': updaterId,
        'created_at': createdAt?.millisecondsSinceEpoch.toString(),
        'updated_at': updatedAt?.millisecondsSinceEpoch.toString(),
        'updater_addr_ip': updaterAddrIp,
      }
    });
  }

  @override
  String toString() {
    return 'ArtistVersion{id: $id, artistId: $artistId, name: $name, urls: $urls, otherNames: $otherNames, groupName: $groupName, isBanned: $isBanned, updaterId: $updaterId, updaterAddrIp: $updaterAddrIp, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArtistVersion &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          artistId == other.artistId &&
          name == other.name &&
          urls == other.urls &&
          otherNames == other.otherNames &&
          groupName == other.groupName &&
          isBanned == other.isBanned &&
          updaterId == other.updaterId &&
          updaterAddrIp == other.updaterAddrIp &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      artistId.hashCode ^
      name.hashCode ^
      urls.hashCode ^
      otherNames.hashCode ^
      groupName.hashCode ^
      isBanned.hashCode ^
      updaterId.hashCode ^
      updaterAddrIp.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}

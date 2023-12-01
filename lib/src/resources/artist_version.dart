part of '../resource.dart';

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

  @override
  const ArtistVersion(
    this.artistId,
    this.name,
    this.groupName,
    this.isBanned,
    this.updaterId, {
    this.urls,
    this.otherNames,
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.updaterAddrIp,
  }) : super();

  @override
  const ArtistVersion._(
    this.artistId,
    this.name,
    this.groupName,
    this.isBanned,
    this.updaterId, {
    this.urls,
    this.otherNames,
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.updaterAddrIp,
  }) : super._(id, createdAt, updatedAt);

  factory ArtistVersion.fromJson(Map<String, dynamic> json) {
    return ArtistVersion._(
      json['artist_id'],
      json['name'],
      json['group_name'],
      json['is_banned'],
      json['updater_id'],
      urls: json['urls'] != null
          ? (json['urls'] as String)
              .split(' ')
              .map((e) => Uri.parse(e))
              .toList()
          : null,
      otherNames: json['other_names'] != null
          ? (json['other_names'] as String).split(' ').toList()
          : null,
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
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

  @override
  ArtistVersion copyWith({
    int? id,
    int? artistId,
    String? name,
    List<Uri>? urls,
    List<String>? otherNames,
    String? groupName,
    bool? isBanned,
    int? updaterId,
    String? updaterAddrIp,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ArtistVersion._(
      artistId ?? this.artistId,
      name ?? this.name,
      groupName ?? this.groupName,
      isBanned ?? this.isBanned,
      updaterId ?? this.updaterId,
      urls: urls ?? this.urls,
      otherNames: otherNames ?? this.otherNames,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      updaterAddrIp: updaterAddrIp ?? this.updaterAddrIp,
    );
  }
}

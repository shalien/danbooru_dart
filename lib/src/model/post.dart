import 'package:meta/meta.dart';
import 'package:xml/xml.dart';

@immutable
final class Post {
  final int id;

  final int uoloaderId;

  final int? approverId;

  final String tagString;

  final String tagStringGeneral;

  final String tagStringArtist;

  final String tagStringCopyright;

  final String tagStringCharacter;

  final String tagStringMeta;

  final String? rating;

  final int? parentId;

  final String source;

  final String md5;

  final Uri fileUrl;

  final Uri largeFileUrl;

  final Uri previewFileUrl;

  final String? ext;

  final String? fileExt;

  final int fileSize;

  final int imageWidth;

  final int score;

  final int favCount;

  final int tagCountGeneral;

  final int tagCountArtist;

  final int tagCopyright;

  final int tagCountCharacter;

  final int tagCountMeta;

  final DateTime? lastCommentBumpedAt;

  final DateTime? lastNotedAt;

  final bool hasChildren;

  final int imageHeight;

  final DateTime createdAt;

  final DateTime updatedAt;

  Post._({
    required this.id,
    required this.uoloaderId,
    required this.approverId,
    required this.tagString,
    required this.tagStringGeneral,
    required this.tagStringArtist,
    required this.tagStringCharacter,
    required this.tagStringMeta,
    required this.rating,
    required this.parentId,
    required this.source,
    required this.md5,
    required this.fileUrl,
    required this.largeFileUrl,
    required this.previewFileUrl,
    required this.ext,
    required this.fileExt,
    required this.fileSize,
    required this.imageWidth,
    required this.score,
    required this.favCount,
    required this.tagCountGeneral,
    required this.tagCountArtist,
    required this.tagCountCharacter,
    required this.tagCountMeta,
    required this.lastCommentBumpedAt,
    required this.tagStringCopyright,
    required this.tagCopyright,
    required this.lastNotedAt,
    required this.hasChildren,
    required this.imageHeight,
    required this.createdAt,
    required this.updatedAt,
  });

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        uoloaderId = json['uploader_id'],
        approverId = json['approver_id'],
        tagString = json['tag_string'],
        tagStringGeneral = json['tag_string_general'],
        tagStringArtist = json['tag_string_artist'],
        tagStringCharacter = json['tag_string_character'],
        tagStringMeta = json['tag_string_meta'],
        rating = json['rating'],
        parentId = json['parent_id'],
        source = json['source'],
        md5 = json['md5'],
        fileUrl = Uri.parse(json['file_url']),
        largeFileUrl = Uri.parse(json['large_file_url']),
        previewFileUrl = Uri.parse(json['preview_file_url']),
        ext = json['ext'],
        fileExt = json['file_ext'],
        fileSize = json['file_size'],
        imageWidth = json['image_width'],
        score = json['score'],
        favCount = json['fav_count'],
        tagCountGeneral = json['tag_count_general'],
        tagCountArtist = json['tag_count_artist'],
        tagCountCharacter = json['tag_count_character'],
        tagCountMeta = json['tag_count_meta'],
        lastCommentBumpedAt = DateTime.parse(json['last_comment_bumped_at']),
        lastNotedAt = DateTime.parse(json['last_noted_at']),
        tagCopyright = json['tag_string_character'],
        tagStringCopyright = json['tag_string_character'],
        hasChildren = json['has_children'],
        imageHeight = json['image_height'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']);

  Post.fromXml(XmlElement xml)
      : id = int.parse(xml.getAttribute('id')!),
        uoloaderId = int.parse(xml.getAttribute('uploader_id')!),
        approverId = int.parse(xml.getAttribute('approver_id')!),
        tagString = xml.getAttribute('tag_string')!,
        tagStringGeneral = xml.getAttribute('tag_string_general')!,
        tagStringArtist = xml.getAttribute('tag_string_artist')!,
        tagStringCharacter = xml.getAttribute('tag_string_character')!,
        tagStringMeta = xml.getAttribute('tag_string_meta')!,
        rating = xml.getAttribute('rating'),
        parentId = int.parse(xml.getAttribute('parent_id')!),
        source = xml.getAttribute('source')!,
        md5 = xml.getAttribute('md5')!,
        fileUrl = Uri.parse(xml.getAttribute('file_url')!),
        largeFileUrl = Uri.parse(xml.getAttribute('large_file_url')!),
        previewFileUrl = Uri.parse(xml.getAttribute('preview_file_url')!),
        ext = xml.getAttribute('ext')!,
        fileSize = int.parse(xml.getAttribute('file_size')!),
        imageWidth = int.parse(xml.getAttribute('image_width')!),
        score = int.parse(xml.getAttribute('score')!),
        favCount = int.parse(xml.getAttribute('fav_count')!),
        tagCountGeneral = int.parse(xml.getAttribute('tag_count_general')!),
        tagCountArtist = int.parse(xml.getAttribute('tag_count_artist')!),
        tagCountCharacter = int.parse(xml.getAttribute('tag_count_character')!),
        tagCountMeta = int.parse(xml.getAttribute('tag_count_meta')!),
        lastCommentBumpedAt =
            DateTime.parse(xml.getAttribute('last_comment_bumped_at')!),
        lastNotedAt = DateTime.parse(xml.getAttribute('last_noted_at')!),
        hasChildren = xml.getAttribute('has_children') == 'true',
        imageHeight = int.parse(xml.getAttribute('image_height')!),
        createdAt = DateTime.parse(xml.getAttribute('created_at')!),
        updatedAt = DateTime.parse(xml.getAttribute('updated_at')!),
        tagCopyright = int.parse(xml.getAttribute('tag_copyright')!),
        tagStringCopyright = xml.getAttribute('tag_string_copyright')!,
        fileExt = xml.getAttribute('file_ext')!;
}

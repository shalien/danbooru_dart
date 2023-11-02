import 'dart:convert';

import 'package:http/http.dart';
import 'package:xml/xml.dart';

import 'data_access_object.dart';
import 'model/post.dart';

const String jsonFormat = 'json';
const String xmlFormat = 'xml';

class DanbooruClient extends BaseClient {
  final Client _client;

  final String host;

  String? username;

  String? apiKey;

  String? get bearerToken => _bearerToken;

  String? _bearerToken;

  late final ArtistDataAccessObject artists;

  DanbooruClient(this.host, {this.username, this.apiKey, Client? client})
      : _client = client ?? Client() {
    // if username or apiKey is set, the other one should be set too else throw an error
    if (username != null && apiKey == null) {
      throw ArgumentError('apiKey is not set');
    } else if (username == null && apiKey != null) {
      throw ArgumentError('username is not set');
    } else if (username != null && apiKey != null) {
      _bearerToken = 'Basic ${base64Encode(utf8.encode('$username:$apiKey'))}';
    }

    artists = ArtistDataAccessObject(this);
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    if (_bearerToken != null) {
      request.headers['Authorization'] = _bearerToken!;
    }

    request.headers['User-Agent'] = 'danbooru_dart/2.0.0';

    return _client.send(request);
  }

  Future<List<Post>> getPosts(
      {int? page,
      List<String>? tags,
      int? limit,
      String? format = jsonFormat,
      String? search}) async {
    if (format == null) {
      format = jsonFormat;
    } else if (format != jsonFormat && format != xmlFormat) {
      throw 'Unsupported format: $format';
    }

    final uri = Uri.https(host, '/posts.$format', {
      ...page != null ? {'page': page.toString()} : {},
      ...limit != null ? {'limit': limit.toString()} : {},
      ...tags != null ? {'tags': tags.join('+')} : {},
      ...search != null ? {'search': search} : {},
    });

    var response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw response;
    }

    switch (format) {
      case jsonFormat:
        var decoded = jsonDecode(response.body);

        return (decoded as List).map((e) => Post.fromJson(e)).toList();
      case xmlFormat:
        var document = XmlDocument.parse(response.body);

        return document.findAllElements('post').map((e) {
          return Post.fromXml(e);
        }).toList();
      default:
        throw 'Unsupported format: $format';
    }
  }

  Future<int?> getPostsCounts({List<String>? tags}) async {
    final uri = Uri.https(host, '/counts/posts.json', {
      ...tags != null ? {'tags': tags.join('+')} : {},
    });

    var response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw response;
    }

    var decoded = jsonDecode(response.body);

    return decoded['counts']['posts'];
  }

  Future<Post?> getPostsRandom(
      {int? limit = 20,
      String? page,
      List<String>? tags,
      String? format = jsonFormat,
      String? search}) async {
    if (format == null) {
      format = jsonFormat;
    } else if (format != jsonFormat && format != xmlFormat) {
      throw 'Unsupported format: $format';
    }

    final uri = Uri.https(host, '/posts/random.$format', {
      ...limit != null ? {'limit': limit.toString()} : {},
      ...page != null ? {'page': page} : {},
      ...tags != null ? {'tags': tags.join('+')} : {},
      ...search != null ? {'search': search} : {},
    });

    var response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw response;
    }

    switch (format) {
      case jsonFormat:
        var decoded = jsonDecode(response.body);

        return Post.fromJson(decoded);
      case xmlFormat:
        var document = XmlDocument.parse(response.body);

        var post = document.findAllElements('post').first;

        return Post.fromXml(post);
      default:
        throw 'Unsupported format: $format';
    }
  }

  Future<int> getMaxPage({List<String>? tags}) async {
    if (await getPostsCounts(tags: tags) == null) {
      return 0;
    }

    var maxPage = (await getPostsCounts(tags: tags))! ~/ 20;

    return maxPage.clamp(0, 1000);
  }
}

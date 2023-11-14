part of '../data_access_object.dart';

@immutable
@internal
final class ArtistCommentaryDataAccessObject
    extends DataAccessObject<ArtistCommentary> {
  ArtistCommentaryDataAccessObject(client) : super('artist_commentary', client);

  @override
  Future<List<ArtistCommentary>> index({
    int page = 0,
    int limit = 1000,
    String? originalTitle,
    String? originalDescription,
    String? translatedTitle,
    String? translatedDescription,
    int? postId,
    dynamic order,
    dynamic createdAt,
    dynamic updatedAt,
    String? textMatches,
    bool? originalPresent,
    bool? translatedPresent,
    bool isDeleted = false,
  }) async {
    final Uri uri = Uri.https(_client.host, '/$endpoint.json', {
      'page': page.toString(),
      'limit': limit.toString(),
      ...order != null ? {'order': order.toString()} : {},
      ...createdAt != null ? {'search[created_at]': createdAt.toString()} : {},
      ...updatedAt != null ? {'search[updated_at]': updatedAt.toString()} : {},
      ...originalTitle != null ? {'search[original_title]': originalTitle} : {},
      ...originalDescription != null
          ? {'search[original_description]': originalDescription}
          : {},
      ...translatedTitle != null
          ? {'search[translated_title]': translatedTitle}
          : {},
      ...translatedDescription != null
          ? {'search[translated_description]': translatedDescription}
          : {},
      ...postId != null ? {'search[post_id]': postId.toString()} : {},
      ...textMatches != null ? {'search[text_matches]': textMatches} : {},
      ...originalPresent != null
          ? {'search[original_present]': originalPresent.toString()}
          : {},
      ...translatedPresent != null
          ? {'search[translated_present]': translatedPresent.toString()}
          : {},
      ...isDeleted ? {'search[is_deleted]': isDeleted.toString()} : {},
    });

    Response response;

    try {
      response = await _client.get(uri, headers: {
        HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
      });
    } on SocketException {
      rethrow;
    } on ClientException {
      rethrow;
    }

    switch (response.statusCode) {
      case >= HttpStatus.badRequest && <= HttpStatus.internalServerError:
        throw ClientException(
            response.reasonPhrase ?? response.body, response.request!.url);
    }
    List<ArtistCommentary> resources = [];

    final decodedBody = jsonDecode(response.body);

    if (decodedBody.length == 0) {
      return resources;
    }

    for (Map<String, dynamic> json in decodedBody) {
      resources.add(fromJson(json));
    }

    return resources;
  }

  @override
  Future<ArtistCommentary> show(int id) async {
    final Uri uri = Uri.https(_client.host, '/$endpoint/$id.json');

    Response response;

    try {
      response = await _client.get(uri);
    } on SocketException {
      rethrow;
    } on ClientException {
      rethrow;
    }

    switch (response.statusCode) {
      case >= HttpStatus.badRequest && <= HttpStatus.internalServerError:
        throw ClientException(
            response.reasonPhrase ?? response.body, response.request!.url);
    }

    final decodedBody = jsonDecode(response.body);

    return fromJson(decodedBody);
  }

  Future<ArtistCommentary> showByPostId(int postId) async {
    final Uri uri = Uri.https(_client.host, '/posts/$postId/$endpoint.json');

    Response response;

    try {
      response = await _client.get(uri);
    } on SocketException {
      rethrow;
    } on ClientException {
      rethrow;
    }

    switch (response.statusCode) {
      case >= HttpStatus.badRequest && <= HttpStatus.internalServerError:
        throw ClientException(
            response.reasonPhrase ?? response.body, response.request!.url);
    }

    final decodedBody = jsonDecode(response.body);

    return fromJson(decodedBody);
  }

  @override
  Future<ArtistCommentary> create(ArtistCommentary resource) async {
    final Uri uri = Uri.https(_client.host, '/$endpoint/create_or_update.json');

    Response response;

    try {
      response = await _client.post(uri,
          body: resource.toJson(),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    } on SocketException {
      rethrow;
    } on ClientException {
      rethrow;
    }

    switch (response.statusCode) {
      case >= HttpStatus.badRequest && <= HttpStatus.internalServerError:
        throw ClientException(
            response.reasonPhrase ?? response.body, response.request!.url);
    }

    final decodedBody = jsonDecode(response.body);

    return fromJson(decodedBody);
  }

  Future<ArtistCommentary> createByPostId(
      ArtistCommentary resource, int postId) async {
    final Uri uri = Uri.https(
        _client.host, '/posts/$postId/$endpoint/create_or_update.json');

    Response response;

    try {
      response = await _client.post(uri,
          body: resource.toJson(),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    } on SocketException {
      rethrow;
    } on ClientException {
      rethrow;
    }

    switch (response.statusCode) {
      case >= HttpStatus.badRequest && <= HttpStatus.internalServerError:
        throw ClientException(
            response.reasonPhrase ?? response.body, response.request!.url);
    }

    final decodedBody = jsonDecode(response.body);

    return fromJson(decodedBody);
  }

  @override
  Future<ArtistCommentary> update(ArtistCommentary resource) async =>
      create(resource);

  Future<ArtistCommentary> updateByPostId(
          ArtistCommentary resource, int postId) async =>
      createByPostId(resource, postId);

  Future<ArtistCommentary> revert(
      ArtistCommentary resource, int versionId) async {
    final Uri uri =
        Uri.https(_client.host, '/$endpoint/${resource.id}/revert.json');

    Response response;

    try {
      response = await _client.put(uri, body: {
        'version_id': versionId.toString(),
      }, headers: {
        HttpHeaders.contentTypeHeader: 'application/json'
      });
    } on SocketException {
      rethrow;
    } on ClientException {
      rethrow;
    }

    switch (response.statusCode) {
      case HttpStatus.notFound:
        throw ClientException(
            response.reasonPhrase ?? response.body, response.request!.url);
    }

    return fromJson(jsonDecode(response.body));
  }

  @override
  ArtistCommentary fromJson(Map<String, dynamic> json) {
    return ArtistCommentary.fromJson(json);
  }

  // Unimplemented methods
}

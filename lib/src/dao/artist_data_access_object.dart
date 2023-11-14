part of '../data_access_object.dart';

/// The [Artist] Data Access Object.
/// Implemented from https://safebooru.donmai.us/wiki_pages/api%3Aartists
final class ArtistDataAccessObject extends DataAccessObject<Artist> {
  const ArtistDataAccessObject(client) : super('artists', client);

  /// Returns a list of [Artist].
  @override
  Future<List<Artist>> index({
    int page = 0,
    int limit = 1000,
    String? name,
    String? groupName,
    bool? isDeleted,
    bool? isBanned,
    List<String>? otherNames,
    String? anyOtherNameLike,
    String? anyNameMatches,
    String? urlsMatches,
    String? anyNameOrUrlMatches,
    dynamic order,
  }) async {
    final Uri uri = Uri.https(_client.host, '/$endpoint.json', {
      'page': page.toString(),
      'limit': limit.toString(),
      ...order != null ? {'order': order.toString()} : {},
      ...name != null ? {'search[name]': name} : {},
      ...groupName != null ? {'search[group_name]': groupName} : {},
      ...isDeleted != null ? {'search[is_deleted]': isDeleted.toString()} : {},
      ...isBanned != null ? {'search[is_banned]': isBanned.toString()} : {},
      ...otherNames != null
          ? {'search[other_names]': otherNames.join(',')}
          : {},
      ...anyOtherNameLike != null
          ? {'search[any_other_name_like]': anyOtherNameLike}
          : {},
      ...anyNameMatches != null
          ? {'search[any_name_matches]': anyNameMatches}
          : {},
      ...urlsMatches != null ? {'search[urls_matches]': urlsMatches} : {},
      ...anyNameOrUrlMatches != null
          ? {'search[any_name_or_url_matches]': anyNameOrUrlMatches}
          : {},
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

    List<Artist> resources = [];

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
  Future<Artist> create(Artist resource) async {
    final Uri uri = Uri.https(_client.host, '/$endpoint.json');

    final Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
    };

    Response response;

    final Map<String, dynamic> body = {
      'artist[name]': resource.name,
      ...resource.groupName != null
          ? {'artist[group_name]': resource.groupName}
          : {},
      ...resource.members != null
          ? {'artist[members]': resource.members!.map((e) => e.name).join(',')}
          : {},
      ...resource.otherNames != null
          ? {'artist[other_names]': resource.otherNames!.join(',')}
          : {},
      ...resource.urls != null
          ? {
              'artist[url_string]':
                  resource.urls!.map((e) => e.toString()).join(',')
            }
          : {},
      ...resource.wikiPage != null
          ? {'artist[wiki_page]': resource.wikiPage}
          : {},
    };

    try {
      response = await _client.post(uri, body: body, headers: headers);
    } on SocketException {
      rethrow;
    } on ClientException {
      rethrow;
    }

    switch (response.statusCode) {
      case HttpStatus.created:
        break;
      case >= HttpStatus.badRequest && <= HttpStatus.internalServerError:
        throw ClientException(response.body, response.request!.url);
    }

    final decodedBody = jsonDecode(response.body);

    return fromJson(decodedBody);
  }

  @override
  Future<Artist> update(Artist resource) async {
    final Uri uri = Uri.https(_client.host, '/$endpoint/${resource.id}.json');

    final Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
    };

    Response response;

    final Map<String, dynamic> body = {
      'artist[name]': resource.name,
      ...resource.groupName != null
          ? {'artist[group_name]': resource.groupName}
          : {},
      ...resource.members != null
          ? {'artist[members]': resource.members!.map((e) => e.name).join(',')}
          : {},
      ...resource.otherNames != null
          ? {'artist[other_names]': resource.otherNames!.join(',')}
          : {},
      ...resource.urls != null
          ? {
              'artist[url_string]':
                  resource.urls!.map((e) => e.toString()).join(',')
            }
          : {},
      ...resource.wikiPage != null
          ? {'artist[wiki_page]': resource.wikiPage}
          : {},
    };

    try {
      response = await _client.put(uri, body: body, headers: headers);
    } on SocketException {
      rethrow;
    } on ClientException {
      rethrow;
    }

    switch (response.statusCode) {
      case HttpStatus.ok:
        break;
      case >= HttpStatus.badRequest && <= HttpStatus.internalServerError:
        throw ClientException(response.body, response.request!.url);
    }

    final decodedBody = jsonDecode(response.body);

    return fromJson(decodedBody);
  }

  @override
  Future<Artist> delete(Artist resource) async {
    final Uri uri = Uri.https(_client.host, '/$endpoint/${resource.id}.json');

    Response response;

    try {
      response = await _client.delete(uri);
    } on SocketException {
      rethrow;
    } on ClientException {
      rethrow;
    }

    switch (response.statusCode) {
      case HttpStatus.ok:
        break;
      case >= HttpStatus.badRequest && <= HttpStatus.internalServerError:
        throw ClientException(response.body, response.request!.url);
    }

    final decodedBody = jsonDecode(response.body);

    return fromJson(decodedBody);
  }

  Future<Artist> undelete(Artist resource) async {
    final Uri uri =
        Uri.https(_client.host, '/$endpoint/${resource.id}/undelete.json');

    Response response;

    try {
      response = await _client.put(uri);
    } on SocketException {
      rethrow;
    } on ClientException {
      rethrow;
    }

    switch (response.statusCode) {
      case HttpStatus.ok:
        break;
      case >= HttpStatus.badRequest && <= HttpStatus.internalServerError:
        throw ClientException(response.body, response.request!.url);
    }

    final decodedBody = jsonDecode(response.body);

    return fromJson(decodedBody);
  }

  Future<List<Artist>> banned() async {
    final Uri uri = Uri.https(_client.host, '/$endpoint/banned.json');

    Response response;

    try {
      response = await _client.get(uri);
    } on SocketException {
      rethrow;
    } on ClientException {
      rethrow;
    }

    List<Artist> resources = [];

    final decodedBody = jsonDecode(response.body);

    if (decodedBody.length == 0) {
      return resources;
    }

    for (Map<String, dynamic> json in decodedBody) {
      resources.add(fromJson(json));
    }

    return resources;
  }

  Future<void> revert(Artist resource, ArtistVersion version) async {
    final Uri uri =
        Uri.https(_client.host, '/$endpoint/${resource.id}/revert.json');

    final Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    Response response;

    try {
      response = await _client.put(uri,
          body: {
            'version_id': version.id.toString(),
          },
          headers: headers);
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
  }

  Future<void> ban(Artist resource) async {
    final Uri uri =
        Uri.https(_client.host, '/$endpoint/${resource.id}/ban.json');

    final Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    Response response;

    try {
      response = await _client.put(uri, headers: headers);
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
  }

  Future<void> unban(Artist resource) async {
    final Uri uri =
        Uri.https(_client.host, '/$endpoint/${resource.id}/unban.json');

    final Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    Response response;

    try {
      response = await _client.put(uri, headers: headers);
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
  }

  @override
  Artist fromJson(Map<String, dynamic> json) {
    return Artist.fromJson(json);
  }
}

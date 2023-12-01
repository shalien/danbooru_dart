import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:meta/meta.dart';

import 'danbooru_client.dart';
import 'resource.dart';

part 'dao/artist_data_access_object.dart';
part 'dao/artist_commentary_data_access_object.dart';

@immutable
@internal
abstract base class DataAccessObject<T extends Resource> {
  final String endpoint;

  final DanbooruClient _client;

  const DataAccessObject(this.endpoint, this._client);

  /// Returns a list of [T] resources.
  @internal
  Future<List<T>> index({
    int page = 0,
    int limit = 1000,
  }) async {
    final Uri uri = Uri.https(_client.host, '/$endpoint.json', {
      'page': page.toString(),
      'limit': limit.toString(),
    });

    Response response;

    try {
      response = await _client.get(uri);
    } on SocketException {
      rethrow;
    } on ClientException {
      rethrow;
    }

    List<T> resources = [];

    final decodedBody = jsonDecode(response.body);

    if (decodedBody.length == 0) {
      return resources;
    }

    for (Map<String, dynamic> json in decodedBody) {
      resources.add(fromJson(json));
    }

    return resources;
  }

  /// Returns a list of [T] resources.
  @internal
  Future<T> show(int id) async {
    final Uri uri = Uri.https(_client.host, '/$endpoint/$id.json');

    Response response;

    try {
      response = await _client.get(uri);
    } on SocketException {
      rethrow;
    } on ClientException {
      rethrow;
    }

    final decodedBody = jsonDecode(response.body);

    return fromJson(decodedBody);
  }

  /// Creates a new [T] resource.
  @internal
  Future<T> create(T resource) async {
    final Uri uri = Uri.https(_client.host, '/$endpoint.json');
    final Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    Response response;

    try {
      response =
          await _client.post(uri, body: resource.toJson(), headers: headers);
    } on SocketException {
      rethrow;
    } on ClientException {
      rethrow;
    }

    final decodedBody = jsonDecode(response.body);

    return fromJson(decodedBody);
  }

  @internal
  Future<T> update(T resource) async {
    final Uri uri = Uri.https(_client.host, '/$endpoint/${resource.id}.json');
    final Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    Response response;

    try {
      response =
          await _client.put(uri, body: resource.toJson(), headers: headers);
    } on SocketException {
      rethrow;
    } on ClientException {
      rethrow;
    }

    final decodedBody = jsonDecode(response.body);

    return fromJson(decodedBody);
  }

  @internal
  Future<void> delete(T resource) async {
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
      case >= HttpStatus.badRequest && <= HttpStatus.internalServerError:
        throw ClientException(
            response.reasonPhrase ?? response.body, response.request!.url);
    }
  }

  @internal
  Future<void> undelete(T resource) async {
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
      case >= HttpStatus.badRequest && <= HttpStatus.internalServerError:
        throw ClientException(
            response.reasonPhrase ?? response.body, response.request!.url);
    }
  }

  @internal
  @mustBeOverridden
  T fromJson(Map<String, dynamic> json);
}

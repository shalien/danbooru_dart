import 'dart:io';

import 'package:danbooru_dart/danbooru_dart.dart';
import 'package:danbooru_dart/src/resources/artist.dart';
import 'package:http/http.dart';
import 'package:sha_env/sha_env.dart';
import 'package:test/test.dart';

void main() async {
  late DanbooruClient client;

  setUpAll(() async {
    await load();

    client = DanbooruClient('testbooru.donmai.us',
        username: env['USERNAME'], apiKey: env['KEY']);
  });

  group('Common data access object method', () {
    test('Index', () async {
      final artists = await client.artists.index();

      print(artists.length);
      print(artists.first.name);

      print(artists.first.toString());

      expect(artists, isNotNull);
    });

    test('Create an artist', () async {
      final artist = Artist('shalien');
      Artist? createdArtist;

      try {
        createdArtist = await client.artists.create(artist);
      } on ClientException catch (e) {
        print(e.message);
        exit(1);
      }
      expect(createdArtist, isNotNull);
    });
  });

  group('Specific tests', () {
    test('Find shalien as artist using name', () async {
      final artists = await client.artists.index(name: 'shalien');

      expect(artists, isEmpty);
    });
  });
}
